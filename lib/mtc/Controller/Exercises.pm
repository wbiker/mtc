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

    $c->stash(exercises => [$c->model('DB::Exercise')->all]);
    my $dump =  Dumper $c->model('DB::Exercise')->all;
    $c->log->info("dump: '$dump'");
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

# here we are. The user has set some information about the new 
# exercise. Was I need:
# name - THe name of the exercise
# category - the category of the exercise [Bauch 1|Brust 2|Rücken 3|Beine 4|Aufwärmen 5]
# file - the uploaded file if set. It is used as picture for the exercise and stored
#   in the filesystem under root/static/images/exercises/<pictureID>.jpg
    
    my $name = $c->req->parameters->{name};
    my $category = $c->req->parameters->{category};

    $c->log->info("Name: $name");
    $c->log->info("Category: $category");

    # First store the picture in the database.
# Unfortunatelly, I need the path for that, but I don't now the PictureID.
# So I create an dummy entry in the picture tables and afterwards use the id to store the 
# picture in the filesystem withthe id as name. THen update the picture table with the proper path
    if(defined $params->{file}) {
        my $pic = $c->model('DB::Picture')->create({ path => 'nothing' });
    # now the entry should have a ID.
        my $id = $pic->id;
        $c->log->info("Hurray the ID: $id");
        my $exercise_pic = "root/static/images/exercises/${id}.jpg";
        $params->{file}->copy_to($exercise_pic);
        $pic->update({path => $exercise_pic});
    }
    else {
        $c->log->debug("No picture");
    }
    
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
