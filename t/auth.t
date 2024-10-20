use Mojo::Base -strict;

use Test::More skip_all => 'Only an example';
use Test::Mojo;

use Mojo::File qw/path curfile/;

use lib path(curfile->dirname, '..', 'lib')->to_string

my $t = Test::Mojo->new('Barabend');
$t->post_ok('/login' => form => { username => 'flo', password => '' })->status_is(200)->content_is('ok');

done_testing();