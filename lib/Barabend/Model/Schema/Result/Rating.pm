use utf8;
package Barabend::Model::Schema::Result::Rating;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Barabend::Model::Schema::Result::Rating

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

=head1 TABLE: C<ratings>

=cut

__PACKAGE__->table("ratings");

=head1 ACCESSORS

=head2 rating_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 rating_value

  data_type: 'integer'
  is_nullable: 1

=head2 rating_comment

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=cut

__PACKAGE__->add_columns(
  "rating_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "rating_value",
  { data_type => "integer", is_nullable => 1 },
  "rating_comment",
  { data_type => "varchar", is_nullable => 1, size => 200 },
);

=head1 PRIMARY KEY

=over 4

=item * L</rating_id>

=back

=cut

__PACKAGE__->set_primary_key("rating_id");

=head1 RELATIONS

=head2 ratings_user_bars

Type: has_many

Related object: L<Barabend::Model::Schema::Result::RatingsUserBar>

=cut

__PACKAGE__->has_many(
  "ratings_user_bars",
  "Barabend::Model::Schema::Result::RatingsUserBar",
  { "foreign.rating_id" => "self.rating_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-29 19:56:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MSabMCdm3pabrnHJGo8EVw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->load_components(qw{Helper::Row::ToJSON});
1;
