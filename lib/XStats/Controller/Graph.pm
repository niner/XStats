package XStats::Controller::Graph;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; with 'CatalystX::Perl6::Controller'; }

__PACKAGE__->init_metaclass;
__PACKAGE__->meta->make_immutable;

use v6-inline;

also does Inline::Perl5::Perl5Parent['XStats::Controller::Graph'];
also does CatalystX::Perl6::Controller;

method show($c) is p5attrs<Path Args(0)> {
    $c.response.body('Matched XStats::Controller::Graph in Graph.');
}
