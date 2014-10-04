package XStats::View::Petal;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::Petal';

=head1 NAME

XStats::View::Petal - Catalyst View

=head1 DESCRIPTION

Catalyst View.


=encoding utf8

=cut

__PACKAGE__->config(input => 'HTML', output => 'HTML');

sub process {
    my ($self, $c) = @_;

    my $root = $c->config->{root};

    my $base_dir = [
        join('/', $root, 'templates'),
    ];

    $self->config(
        base_dir => $base_dir,
    ); # this sets the global config, so we have to do it for every request

    $c->stash({
        uri_static               => $c->uri_for('/static'),
    });

    return $self->SUPER::process($c);
}

=head1 AUTHOR

Stefan Seifert

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
