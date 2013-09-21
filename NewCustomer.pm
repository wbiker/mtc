package mtc::Form::NewExercise;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';
use namespace::autoclean;

has '+enctype' => ( default => 'multipart/form-data');
has '+item_class' => ( default => 'mtc' );
has_field 'name' => ( label => 'Name', required => 1);
has_field 'category' => ( type => 'Select', options_method => \&category_options );
has_field 'file' => ( type => 'Upload', max_size => '3000000' );
has_field 'submit' => ( type => 'Submit', value => 'Upload' );

sub category_options {
    return [ 
                { value => 1, label => 'Bauch' },
                { value => 2, label => 'Rücken' },
                { value => 3, label => 'Brust' },
                { value => 4, label => 'Beine' },
                { value => 5, label => 'Aufwärmen' },
           ]
}
1;
