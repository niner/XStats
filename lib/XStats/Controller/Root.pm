package XStats::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $Perl6::XStats::Controller::Root->index($self, $c);
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub end : ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;

{
    no warnings 'redefine';
    my $new = \&XStats::Controller::Root::new;
    *XStats::Controller::Root::new = sub {
        warn $Perl6::ObjectCreator->create(__PACKAGE__, $new->(@_));
        return $new->(@_);
    };
}

use v6-inline;

also does Inline::Perl5::Perl5Parent['XStats::Controller::Root'];

method COMPONENT {
    warn "COMPONENT!";
}

method index($c) {
    # Hello World
    $c.response.body( $c.welcome_message );
}
