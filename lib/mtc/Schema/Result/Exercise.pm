use utf8;
package mtc::Schema::Result::Exercise;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

mtc::Schema::Result::Exercise

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

=head1 TABLE: C<exercise>

=cut

__PACKAGE__->table("exercise");

=head1 ACCESSORS

=head2 eid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 cid

  data_type: 'integer'
  is_nullable: 0

=head2 pid

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "eid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "cid",
  { data_type => "integer", is_nullable => 0 },
  "pid",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</eid>

=back

=cut

__PACKAGE__->set_primary_key("eid");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-11 12:10:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:a0e/T91YuPniJnTEXSZ6Vw

__PACKAGE__->has_many("category", "mtc::Schema::Result::Category", { 'foreign.cid' => 'self.cid'  }, { cascade_delete => 0});
__PACKAGE__->has_many("picture", "mtc::Schema::Result::Picture", { 'foreign.pid' => 'self.pid' } );

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
