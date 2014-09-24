class Perl6::MOP;

use Inline::Perl5;

has $.parent;

class P6Method {
    has $.method;

    method can($name) {
        return self.^can($name);
    }

    method name {
        return $.method.gist;
    }

    method attributes {
        return $.method.attributes;
    }

    method body {
        return $.method;
    }
}

method name {
    return $.parent.name;
}

method get_nearest_methods_with_attributes {
    my $class = ::($.parent.name);

    return
        |$class.^methods\
            .grep({$_.^does(::Inline::Perl5::Perl5Attributes)})\
            .map({P6Method.new(method => $_)}),
        |$.parent.get_nearest_methods_with_attributes;
}

method can($name) {
    return self.^can($name);
}

method linearized_isa {
    return $.parent.linearized_isa;
}

# vim: ft=perl6
