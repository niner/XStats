package XStats::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; with 'CatalystX::Perl6::Controller'; }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

__PACKAGE__->init_metaclass;
__PACKAGE__->meta->make_immutable;

use v6-inline;

also does Inline::Perl5::Perl5Parent['XStats::Controller::Root'];
also does CatalystX::Perl6::Controller;

method index($c) is p5attrs['Path', 'Args(0)'] {
    # Hello World
    $c.response.body( $c.welcome_message );
}

method default($c) is p5attrs['Path'] {
    $c.response.body( 'Page not found' );
    $c.response.status(404);
}

method test($c) is p5attrs['Local'] {
    $c.res.body('Test!');
}

method end($c) is p5attrs['ActionClass("RenderView")'] {
}
