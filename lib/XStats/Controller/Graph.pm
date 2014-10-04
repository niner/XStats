package XStats::Controller::Graph;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; with 'CatalystX::Perl6::Component'; }

__PACKAGE__->init_metaclass;
__PACKAGE__->meta->make_immutable;

use v6-inline;

use SVG::Plot;
use SVG;

also does Inline::Perl5::Perl5Parent['XStats::Controller::Graph'];
also does CatalystX::Perl6::Component;

method show($c) is p5attrs<Path Args(0)> {
    $c.response.content_type('image/svg+xml');
    my $results = $c.model('Awstats').parse($c).days;
    my $days = $results.hash<line_day>;
    my @labels = $days.map({~$_.hash<date><day>});
    my @values = $days.map({+$_.hash<visits>});
    my $svg = SVG::Plot.new(
            :width(600),
            :height(550),
            :plot-height(400),
            :fill-width(2),
            :title('Visitors per day'),
            :values([$(@values)]),
            :labels(@labels),
            :colors<lightgray>
        ).plot(:bars);

    $c.res.body(SVG.serialize(svg => $svg));
}
