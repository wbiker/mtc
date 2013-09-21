package mtc::Form::NewTrainingsplan;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';
use namespace::autoclean;

has '+item_class' => ( default => 'mtc' );
has_field 'name' => ( label => 'Name', required => 1, messages => { required => 'Du mußt dem Trainingsplan einem Namen geben', });
has_field 'customers' => ( type => 'Select');
has_field 'submit' => ( type => 'Submit', value => 'Upload' );

1;
