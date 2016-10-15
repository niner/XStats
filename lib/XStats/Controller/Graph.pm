package XStats::Controller::Graph;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

__PACKAGE__->meta->make_immutable;

use v6::inline;

use SVG::Plot;
use SVG;

use CatalystX::Perl6::Component::Perl5Attributes;

method show($c, *@args) is Path is Args(0) {
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
            :values([$@values]),
            :labels(@labels),
            :colors<gray>
        ).plot(:lines);

    $c.res.body(SVG.serialize(svg => $svg));
}
