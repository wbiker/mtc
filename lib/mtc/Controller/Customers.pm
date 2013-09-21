package mtc::Controller::Customers;
use Moose;
use namespace::autoclean;
use mtc::Form::NewCustomer;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

mtc::Controller::Customers - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 Customers

Lists all customers

=cut

sub index :Path Args(0) {
    my ($self, $c) = @_;

    $c->stash(template => 'customers/list.tt2');
    $c->stash(customers => $c->model('DB::Customer'));
    my $customers = $c->model('DB::Customer');
    my $deb = "Count: ".$customers->count."\n";
    my $row = $customers->next;
    $deb .= "firstname ".$row->firstname."\n";
    $deb .= "lastname ".$row->lastname."\n";
    $deb .= "age ".$row->age."\n";
    $c->stash(debug => $deb);
}

sub add :Local :Args(0) {
    my ($self, $c) = @_;

    my $form = mtc::Form::NewCustomer->new;
    $c->stash(form => $form);

    $form->process(params => $c->req->parameters);

    return unless $form->validated;

    my $customer = $c->model('DB::Customer');
    $customer->create({ firstname => $c->req->parameters->{firstname}, 
        lastname => $c->req->parameters->{lastname},
        age => $c->req->parameters->{age}, });

}

=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
