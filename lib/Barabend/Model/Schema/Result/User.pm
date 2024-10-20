use utf8;
package Barabend::Model::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Barabend::Model::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_name

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 password_hash

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 salt

  data_type: 'char'
  is_nullable: 0
  size: 50

To salt hash

=head2 role

  data_type: 'integer'
  default_value: 3
  is_foreign_key: 1
  is_nullable: 0

Speicify the role of the user (1:1 Relationship)

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_name",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "password_hash",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "salt",
  { data_type => "char", is_nullable => 0, size => 50 },
  "role",
  {
    data_type      => "integer",
    default_value  => 3,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique_user_name>

=over 4

=item * L</user_name>

=back

=cut

__PACKAGE__->add_unique_constraint("unique_user_name", ["user_name"]);

=head1 RELATIONS

=head2 event_participants

Type: has_many

Related object: L<Barabend::Model::Schema::Result::EventParticipant>

=cut

__PACKAGE__->has_many(
  "event_participants",
  "Barabend::Model::Schema::Result::EventParticipant",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ratings_user_bars

Type: has_many

Related object: L<Barabend::Model::Schema::Result::RatingsUserBar>

=cut

__PACKAGE__->has_many(
  "ratings_user_bars",
  "Barabend::Model::Schema::Result::RatingsUserBar",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 role

Type: belongs_to

Related object: L<Barabend::Model::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "role",
  "Barabend::Model::Schema::Result::Role",
  { role_id => "role" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 events

Type: many_to_many

Composing rels: L</event_participants> -> event

=cut

__PACKAGE__->many_to_many("events", "event_participants", "event");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-12-22 15:30:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WIoCZer3KeC8RuN2wxSbGA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->load_components(qw{Helper::Row::ToJSON});
1;
