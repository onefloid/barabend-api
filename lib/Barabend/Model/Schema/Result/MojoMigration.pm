use utf8;
package Barabend::Model::Schema::Result::MojoMigration;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Barabend::Model::Schema::Result::MojoMigration

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

=head1 TABLE: C<mojo_migrations>

=cut

__PACKAGE__->table("mojo_migrations");

=head1 ACCESSORS

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 version

  data_type: 'bigint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "name",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "version",
  { data_type => "bigint", is_nullable => 0 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-12-22 15:30:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bkmCHQdeNTdBHDMg9rbtDQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
