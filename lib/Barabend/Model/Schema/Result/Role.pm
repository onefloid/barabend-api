use utf8;
package Barabend::Model::Schema::Result::Role;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Barabend::Model::Schema::Result::Role

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

=head1 TABLE: C<roles>

=cut

__PACKAGE__->table("roles");

=head1 ACCESSORS

=head2 role_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

Unique role id

=head2 role_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

Name of the role

=head2 role_description

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Describe the group

=cut

__PACKAGE__->add_columns(
  "role_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "role_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "role_description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</role_id>

=back

=cut

__PACKAGE__->set_primary_key("role_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique_role_name>

=over 4

=item * L</role_name>

=back

=cut

__PACKAGE__->add_unique_constraint("unique_role_name", ["role_name"]);

=head1 RELATIONS

=head2 users

Type: has_many

Related object: L<Barabend::Model::Schema::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "Barabend::Model::Schema::Result::User",
  { "foreign.role" => "self.role_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-12-22 15:30:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:v0nI/HYfB7gGR1Sfr2LEWQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
