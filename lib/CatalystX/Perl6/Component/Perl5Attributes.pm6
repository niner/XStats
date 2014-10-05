our role Perl5Attributes[Routine $r] {
    has $.attributes = [];
}

multi trait_mod:<is>(Routine $declarand!, :@p5attrs!) is export {
    $declarand does Perl5Attributes[$declarand] unless $declarand.does(Perl5Attributes);
    $declarand.attributes.push(@p5attrs);
}

multi trait_mod:<is>(Routine $declarand!, :$Path!) is export {
    $declarand does Perl5Attributes[$declarand] unless $declarand.does(Perl5Attributes);
    $declarand.attributes.push('Path' ~ ($Path.isa('Bool') ?? '' !! "('$Path')"));
}

multi trait_mod:<is>(Routine $declarand!, :$Args!) is export {
    $declarand does Perl5Attributes[$declarand] unless $declarand.does(Perl5Attributes);
    $declarand.attributes.push("Args($Args)");
}

multi trait_mod:<is>(Routine $declarand!, :$ActionClass!) is export {
    $declarand does Perl5Attributes[$declarand] unless $declarand.does(Perl5Attributes);
    $declarand.attributes.push("ActionClass('$ActionClass')");
}
