package Barabend::Plugin::Schema;
use Mojo::Base 'Mojolicious::Plugin', -signatures;
use Barabend::Model::Schema;

sub register ($self, $app, $config) {
    
    my $dbi_params = {mysql_enable_utf8 => 1}; 
    my $schema =  Barabend::Model::Schema->connect($config->{dsn}, $config->{sql_user}, $config->{sql_pw}, $dbi_params);
  
    $app->helper('schema' => sub { return $schema });
}

1;