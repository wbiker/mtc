use utf8;
package mtc::Schema::Result::Customer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

mtc::Schema::Result::Customer

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

=head1 TABLE: C<customer>

=cut

__PACKAGE__->table("customer");

=head1 ACCESSORS

=head2 cid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 firstname

  data_type: 'text'
  is_nullable: 0

=head2 lastname

  data_type: 'text'
  is_nullable: 0

=head2 age

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "cid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "firstname",
  { data_type => "text", is_nullable => 0 },
  "lastname",
  { data_type => "text", is_nullable => 0 },
  "age",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cid>

=back

=cut

__PACKAGE__->set_primary_key("cid");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-10 16:43:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:l919o3/WzJHWaPG3jRXH2w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
