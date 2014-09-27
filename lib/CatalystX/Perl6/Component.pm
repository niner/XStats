package CatalystX::Perl6::Component;

use Moose::Role;

sub COMPONENT {
    my ($class, $app, $args) = @_;
    my $self = $class->new($app, $args);
    my $p6 = $Perl6::ObjectCreator->create($class, $self);
    bless $self, "Perl6::Object::$class"; # Explodes if we bless $p6 here!
    return $p6;
}

sub init_metaclass {
    my ($class) = @_;

    my $perl6_class = "Perl6::Object::$class";
    {
        no strict 'refs';
        @{ $perl6_class . "::ISA" } = qw(Perl6::Object);
    }

    Class::MOP::store_metaclass_by_name(
        $perl6_class,
        $Perl6::ObjectCreator->create('Perl6::MOP', $class->meta)
    );
}

1;
