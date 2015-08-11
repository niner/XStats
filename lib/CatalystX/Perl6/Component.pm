package CatalystX::Perl6::Component;

use Moose::Role;

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
