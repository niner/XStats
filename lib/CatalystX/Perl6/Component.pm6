unit role CatalystX::Perl6::Component;

method can($name) {
    return $.parent.perl5.invoke(self.^name, 'can', $name);
}
