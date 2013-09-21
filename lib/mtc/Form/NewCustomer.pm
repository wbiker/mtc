package mtc::Form::NewCustomer;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';
use namespace::autoclean;

has '+item_class' => ( default => 'mtc' );
has_field 'firstname' => ( label => 'Vorname', required => 1);
has_field 'lastname' => ( label => 'Nachname', required => 1);
has_field 'age' => ( label => 'Geburtsjahr');
has_field 'submit' => ( type => 'Submit', value => 'Upload' );

1;
