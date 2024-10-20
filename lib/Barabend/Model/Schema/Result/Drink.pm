use utf8;
package Barabend::Model::Schema::Result::Drink;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Barabend::Model::Schema::Result::Drink

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<drinks>

=cut

__PACKAGE__->table("drinks");

=head1 ACCESSORS

=head2 drink_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 drink_name

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "drink_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "drink_name",
  { data_type => "varchar", is_nullable => 1, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</drink_id>

=back

=cut

__PACKAGE__->set_primary_key("drink_id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-01-22 17:24:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LYCrPJUx8W5frK+/atzelw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->load_components(qw{Helper::Row::ToJSON});
1;
