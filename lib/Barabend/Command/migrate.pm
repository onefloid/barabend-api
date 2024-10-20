package Barabend::Command::migrate;
use Mojo::Base 'Mojolicious::Command', -signatures;

use Mojo::Util 'getopt';

use Mojo::mysql;
use Mojo::File qw/curfile/;
use Mojo::mysql::Migrations;

has description => 'Migrate database schema';
#has usage       => "Usage: APPLICATION spy [TARGET]\n";
has usage => sub ($self) { $self->extract_usage };
 
sub run ($self, @args) {
  
  getopt(
    \@args,
    'v|version=i' => \my $version,
  );
  
  say "Start migration...";

  my $mysql = Mojo::mysql->strict_mode('mysql://root@localhost/barabend');
  my $migrations = Mojo::mysql::Migrations->new(mysql => $mysql );

  if ( defined $version ) {
    say ("Migrate to Version:       $version");
  }
  else{
    say ("Migrate to Version:       latest");
  }
 

  my $current_version = $migrations->active;
  say ("Version before migration: $current_version");

  $migrations->from_file(Mojo::File->new(curfile->dirname, ('..') x 3, 'migrations', 'migrations.sql'));
  $migrations->migrate( defined $version ? $version : () );

  $current_version = $migrations->active;
  say ("Version after  migration: $current_version");

  say "Finished migration";
 
}
 
=head1 SYNOPSIS
 
  Usage: migrate [OPTIONS]
 
  OPTIONS:
    -v , --version  the version to deploy, defaults to latest
    -h , --help     show this help
 
=cut

1;