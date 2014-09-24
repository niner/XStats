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

    return $self->index($c);
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub end : ActionClass('RenderView') {}

sub COMPONENT {
    my ($class, $app, $args) = @_;
    my $self = $class->new($app, $args);
    return $Perl6::ObjectCreator->create(__PACKAGE__, $self);
}

__PACKAGE__->meta->make_immutable;

Class::MOP::store_metaclass_by_name('Perl6::Object', __PACKAGE__->meta);

use v6-inline;

also does Inline::Perl5::Perl5Parent['XStats::Controller::Root'];
method index($c) {
    # Hello World
    $c.response.body( $c.welcome_message );
}

method can($name) {
    return $.parent.perl5.invoke('XStats::Controller::Root', 'can', $name);
}
