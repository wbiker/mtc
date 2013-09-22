package mtc::Controller::Exercises;
use Moose;
use namespace::autoclean;
use Data::Dumper;
use Imager;

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
    $c->stash(exercises => $c->model('DB::Exercise'));
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
    my $id;
    if(defined $params->{file}) {
        my $pic = $c->model('DB::Picture')->create({ path => 'nothing' });
    # now the entry should have a ID.
        $id = $pic->id;
        $c->log->info("Hurray the ID: $id");
        my $exercise_pic = "/static/images/exercises/${id}.jpg";
        my $upload = $params->{file};
        $upload->copy_to("root$exercise_pic") or $c->log->error("Could not store uploaded file in $exercise_pic: $!");

# make a thumbnail
        my $img = Imager->new;
        $img->read( file => "root$exercise_pic" ) or die $img->errstr;
        my $copyimg = $img->copy();
        $copyimg = $copyimg->scale(xpixel => '50');
        $copyimg->write(file => "root$exercise_pic") or die $copyimg->errstr;
        $pic->update({path => $exercise_pic});
        $c->stash(debug => $c->uri_for());
    }
    else {
        $c->log->debug("No picture");
    }
    
# Next get the exercise class and store the new exercise along with the picture if set.
    my $exercise = $c->model("DB::Exercise")->create({ name => $name, cid => $category, pid => $id}); 
}

sub base :Chained('') :PathPart('exercises') :CaptureArgs(1) {
    my ($self, $c, $exercise_id) = @_;

    $c->log->info("chained action with exercise id $exercise_id");
    # fetch exercise and store it in the stash for the next chained action
    my $ex = $c->model('DB::Exercise')->find({ eid => $exercise_id });
    $c->stash(exercise => $ex);
}

sub delete :Chained("base") :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

# delete exercise in database
    my $rs =  $c->stash->{exercise};
    $c->log->debug("Delete exercise with the id ".$rs->{id});
    $rs->delete;
    $c->res->redirect($c->uri_for(''));
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
