package mtc::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    WRAPPER => 'main',
    render_die => 1,
    INCLUDE_PATH => [
        mtc->path_to('root', 'src'),
    ],
);

=head1 NAME

mtc::View::TT - TT View for mtc

=head1 DESCRIPTION

TT View for mtc.

=head1 SEE ALSO

L<mtc>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
