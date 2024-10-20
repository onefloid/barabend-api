use utf8;
package Barabend::Model::Schema::Result::Bar;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Barabend::Model::Schema::Result::Bar

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

=head1 TABLE: C<bars>

=cut

__PACKAGE__->table("bars");

=head1 ACCESSORS

=head2 bar_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 bar_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 street

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 plz

  data_type: 'varchar'
  is_nullable: 1
  size: 5

=head2 city

  data_type: 'varchar'
  default_value: 'Frankfurt am Main'
  is_nullable: 1
  size: 25

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 1000

=head2 district

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 drinks

  data_type: 'set'
  extra: {list => ["Beer","Wine","Cocktails","Gin","Whisky"]}
  is_nullable: 1

What drinks is the bar famous for

=cut

__PACKAGE__->add_columns(
  "bar_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "bar_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "street",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "plz",
  { data_type => "varchar", is_nullable => 1, size => 5 },
  "city",
  {
    data_type => "varchar",
    default_value => "Frankfurt am Main",
    is_nullable => 1,
    size => 25,
  },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 1000 },
  "district",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "drinks",
  {
    data_type => "set",
    extra => { list => ["Beer", "Wine", "Cocktails", "Gin", "Whisky"] },
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</bar_id>

=back

=cut

__PACKAGE__->set_primary_key("bar_id");

=head1 RELATIONS

=head2 events

Type: has_many

Related object: L<Barabend::Model::Schema::Result::Event>

=cut

__PACKAGE__->has_many(
  "events",
  "Barabend::Model::Schema::Result::Event",
  { "foreign.location" => "self.bar_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ratings_user_bars

Type: has_many

Related object: L<Barabend::Model::Schema::Result::RatingsUserBar>

=cut

__PACKAGE__->has_many(
  "ratings_user_bars",
  "Barabend::Model::Schema::Result::RatingsUserBar",
  { "foreign.bar_id" => "self.bar_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-01-22 17:24:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QRCr0/wLJE0vlIBrwy+yhw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->load_components(qw{Helper::Row::ToJSON});
__PACKAGE__->inflate_column('drinks' => {
    inflate => sub{
      my ($drinks_string, $event_result_object) = @_;
      my @drinks= split(',', $drinks_string);
      return \@drinks; 
    },
    deflate => sub{
      my ($drinks_array, $event_result_object) = @_;
      my $drinks_string = join(',', $drinks_array->@*);
      return $drinks_string; 
    }
});
1;
