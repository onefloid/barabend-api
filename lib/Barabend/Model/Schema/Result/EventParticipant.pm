use utf8;
package Barabend::Model::Schema::Result::EventParticipant;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Barabend::Model::Schema::Result::EventParticipant

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

=head1 TABLE: C<event_participants>

=cut

__PACKAGE__->table("event_participants");

=head1 ACCESSORS

=head2 event_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "event_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</event_id>

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("event_id", "user_id");

=head1 RELATIONS

=head2 event

Type: belongs_to

Related object: L<Barabend::Model::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "event",
  "Barabend::Model::Schema::Result::Event",
  { event_id => "event_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);

=head2 user

Type: belongs_to

Related object: L<Barabend::Model::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Barabend::Model::Schema::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-29 19:56:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oYIz1RbXtOp2qmyIgYCYlQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->load_components(qw{Helper::Row::ToJSON});
1;
