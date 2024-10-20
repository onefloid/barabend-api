use utf8;
package Barabend::Model::Schema::Result::Event;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Barabend::Model::Schema::Result::Event

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

=head1 TABLE: C<events>

=cut

__PACKAGE__->table("events");

=head1 ACCESSORS

=head2 event_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 event_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 location

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "event_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "event_date",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "location",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</event_id>

=back

=cut

__PACKAGE__->set_primary_key("event_id");

=head1 RELATIONS

=head2 event_participants

Type: has_many

Related object: L<Barabend::Model::Schema::Result::EventParticipant>

=cut

__PACKAGE__->has_many(
  "event_participants",
  "Barabend::Model::Schema::Result::EventParticipant",
  { "foreign.event_id" => "self.event_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 location

Type: belongs_to

Related object: L<Barabend::Model::Schema::Result::Bar>

=cut

__PACKAGE__->belongs_to(
  "location",
  "Barabend::Model::Schema::Result::Bar",
  { bar_id => "location" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "RESTRICT",
  },
);

=head2 users

Type: many_to_many

Composing rels: L</event_participants> -> user

=cut

__PACKAGE__->many_to_many("users", "event_participants", "user");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-29 19:56:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ogS+7dF5ElPXYr6nlLlS9Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->load_components(qw{Helper::Row::ToJSON});
1;
