package mtc::Controller::Exercises;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

mtc::Controller::Exercises - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    $c->stash(template => 'exercises/list.tt2');

    $c->stash(exercises => [$c->model('DBIC::Exercise')->all]);
    my $dump =  Dumper $c->model('DBIC::Exercise')->all;
    $c->log->info("dump: $dump");
    $c->stash(debug => $dump);
}

=head2 add

Add a new exercise to the database

=cut

sub add :Local {
    my ($self, $c) = @_;

    $c->stash(template => 'addExercise.tt2');
    my $form = mtc::Form::NewExercise->new;

    $c->stash(form => $form);

    my $params = $c->req->params;
    $params->{file} = $c->req->upload('file') if $c->req->method eq 'POST';
    $form->process(params => $params);

    return unless $form->validated;

    $c->log->info("Name: ".$c->req->parameters->{name});
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
