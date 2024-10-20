use utf8;
package Barabend::Model::Schema::Result::BarsDrink;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Barabend::Model::Schema::Result::BarsDrink

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

=head1 TABLE: C<bars_drinks>

=cut

__PACKAGE__->table("bars_drinks");

=head1 ACCESSORS

=head2 bar_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 drink_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "bar_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "drink_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</bar_id>

=item * L</drink_id>

=back

=cut

__PACKAGE__->set_primary_key("bar_id", "drink_id");

=head1 RELATIONS

=head2 bar

Type: belongs_to

Related object: L<Barabend::Model::Schema::Result::Bar>

=cut

__PACKAGE__->belongs_to(
  "bar",
  "Barabend::Model::Schema::Result::Bar",
  { bar_id => "bar_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);

=head2 drink

Type: belongs_to

Related object: L<Barabend::Model::Schema::Result::Drink>

=cut

__PACKAGE__->belongs_to(
  "drink",
  "Barabend::Model::Schema::Result::Drink",
  { drink_id => "drink_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-29 19:50:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:s0e2QvSHEwmVg/t/BcSRaA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->load_components(qw{Helper::Row::ToJSON});
1;
