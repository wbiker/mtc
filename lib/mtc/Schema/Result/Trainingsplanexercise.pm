use utf8;
package mtc::Schema::Result::Trainingsplanexercise;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

mtc::Schema::Result::Trainingsplanexercise

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<trainingsplanexercise>

=cut

__PACKAGE__->table("trainingsplanexercise");

=head1 ACCESSORS

=head2 teid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 tid

  data_type: 'integer'
  is_nullable: 0

=head2 eid

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "teid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "tid",
  { data_type => "integer", is_nullable => 0 },
  "eid",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</teid>

=back

=cut

__PACKAGE__->set_primary_key("teid");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-11 12:10:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:07vcpVLRC0mgo4RAKdyvpQ

__PACKAGE__->has_many("tid", "mtc::Schema::Result::Trainingsplan", { "foreign.tid" => 'self.tid' });
__PACKAGE__->has_many("eid", "mtc::Schema::Result::Exercise", { "foreign.eid" => 'self.eid' });

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
