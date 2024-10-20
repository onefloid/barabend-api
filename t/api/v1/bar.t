use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use Mojo::File qw/path curfile/;

use lib path(curfile->dirname, ('..') x 3, 'lib')->to_string;

my $t = Test::Mojo->new('Barabend');

# Test get routes
get_test('/api/v1/bar');
get_test('/api/v1/bar/1');
get_test('/api/v1/bar?id=1');
get_test('/api/v1/bar?bar_name=BB%20Bar');
get_test('/api/v1/bar?plz=60313');
get_test('/api/v1/bar?street=Kaiserhofstr.%2018');

# Test CUD routes
my $new_bar = {
  "bar_id" => 1024,
  "bar_name" => "Test Bar",
  "street" => "Im Busch 99",
  "district" => "Sachsenhausen",
  "city" => "Frankfurt am Main",
  "plz" => "60111",
  "description" => "Amazing bar",
  "drinks" => ["Beer","Wine"]
  };

# Test if CUD routes are protected 
$t->post_ok('/api/v1/bar' => {Accept => 'application/json'} => json => $new_bar)
  ->status_is(401)
  ->content_type_is('application/json;charset=UTF-8');

$t->delete_ok('/api/v1/bar' => {Accept => 'application/json'} => json => $new_bar)
  ->status_is(401)
  ->content_type_is('application/json;charset=UTF-8');

$t->put_ok('/api/v1/bar' => {Accept => 'application/json'} => json => $new_bar)
  ->status_is(401)
  ->content_type_is('application/json;charset=UTF-8');

# Mock auth
$t->app->helper('is_authorized' => sub {
    my ($c, %params) = @_;
    return 1;
});

$t->app->helper('validate_api_key' => sub {
    my ($c, %params) = @_;
    return 1;
});

$t->post_ok('/api/v1/bar' => {Accept => 'application/json', 'X-Api-Key' => 'xxx'} => json => $new_bar)
  ->status_is(201)
  ->content_type_is('application/json;charset=UTF-8');

my $updated_bar = {
  "bar_id" => 1024,
  "bar_name" => "Test Bar Neu",
};

$t->put_ok('/api/v1/bar' => {Accept => 'application/json', 'X-Api-Key' => 'xxx'} => json => $updated_bar)
  ->status_is(200)
  ->content_type_is('application/json;charset=UTF-8')
  ->json_is('/bar_name' , 'Test Bar Neu');
  ;

$t->delete_ok('/api/v1/bar' => {Accept => 'application/json', 'X-Api-Key' => 'xxx'} => json => $new_bar)
  ->status_is(200)
  ->content_type_is('application/json;charset=UTF-8')
  ;

sub get_test{
    my $url = shift;
    
    $t->get_ok($url)
      ->status_is(200)
      ->content_type_is('application/json;charset=UTF-8')
      ->json_has('/0/bar_id', 'has a bar id')
      ->json_has('/0/bar_name', 'has a bar name')
      ->json_has('/0/city', 'has a city')
      ->json_has('/0/description', 'has a description')
      ->json_has('/0/district', 'has a district')
      ->json_has('/0/plz', 'has a plz')
      ->json_has('/0/street', 'has a street');
}

done_testing();
