package mtc::Controller::Trainingsplans;
use Moose;
use namespace::autoclean;
use mtc::Form::NewTrainingsplan;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

mtc::Controller::Trainingsplans - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub list :Local :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(template => 'trainingsplans/list.tt2');
    $c->stash(trainingplans => $c->model('DB::Trainingsplan'));
}

sub base :Chained('/') :PathPart('trainingsplans') :CaptureArgs(1) {
    my ($self, $c, $trainingsplan_id) = @_;

    $c->log->info('Chained action!');
    my $plan = $c->model('DB::Trainingsplan')->single({ tid => $trainingsplan_id});
    $c->stash(plan => $plan);
}

sub show :Chained('base') :Args(0) {
    my ($self, $c) = @_;
    
    my $planid = $c->stash->{plan}->tid;
    my $exercises = $c->model('DB')->get_exercises_for_planid($c, $planid);
    $c->log->debug("Count: ".$exercises->count);
    $c->stash(exercises => $exercises);
}

sub add_exercise :Chained('base') :Args(0) {
    my ($self, $c) = @_;
    
    my $exercises = $c->model('DB::Exercise');
    $c->stash(exercises => $exercises);
}

sub add :Local :Args(0) {
    my ($self, $c) = @_;

    my $form = mtc::Form::NewTrainingsplan->new;
    $c->stash(form => $form);
    my $params = $c->req->parameters;

    my $modelDB = $c->model('DB');
    my $labels = $modelDB->get_customer_for_select;
    my $out = Dumper $labels;
    $c->stash(debug => $out);
    $form->field('customers')->options($labels);
    $form->process(params => $params);

    return unless $form->validated;
    $c->stash(debug => $form->values);
    my $plan = $c->model('DB::Trainingsplan');
    $plan->create({ name => $c->req->parameters->{name}, cid => $c->req->parameters->{customers }});
}

sub addexercises :Chained('base') :Args(0) {
    my ($self, $c) = @_;

    my $ex = $c->req->parameters->{exercise};
    my $dum = Dumper \$ex;
    $c->log->debug($dum);

    my $plan = $c->stash->{plan};
    $c->log->debug("Plan id = ".$plan->tid);

    my $tpe = $c->model('DB::Trainingsplanexercise');
# write the trainingplansexercise entries.
    if(ref ($ex) eq 'ARRAY') {
        for my $eid (@{$ex}) {
            $tpe->create({ tid => $plan->tid, eid => $eid });
        }
    }
    else {
        $tpe->create({ tid => $plan->tid, eid => $ex });
    }

    $c->res->redirect($c->uri_for($plan->tid, 'show'));
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
