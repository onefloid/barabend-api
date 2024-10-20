use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use Mojo::File qw/path curfile/;

use lib path(curfile->dirname, '..', 'lib')->to_string;

my $t = Test::Mojo->new('Barabend');
$t->get_ok('/api')->status_is(200);

done_testing();
