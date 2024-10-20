package Barabend;
use Mojo::Base 'Mojolicious', -signatures;
use Mojo::File qw/curfile path/;

use Mojo::File qw(path);
use lib path(qw(lib))."";
use Barabend::Auth::Util qw(load_user validate_user);
 
# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  $self->plugin('Barabend::Plugin::Schema' => $config);
  $self->plugin('Barabend::Plugin::Auth');
  $self->plugin('Barabend::Plugin::Error');


  # Add another namespace to load commands from
  push @{$self->commands->namespaces}, 'Barabend::Command';

  # Load OpenAPI schema 
  $self->plugin(
    "OpenAPI" => {
      spec => $self->static->file("api.yml")->path,
      security => {
        apiKey => sub {
          my ($c, $definition, $scopes, $cb) = @_;
          #$c->app->log->debug("Entered security call back");
          if ( $c->req->headers->header('X-Api-Key') ) {
            if ( $c->validate_api_key() ) {
              return $c->$cb();
            }
            else {
              return $c->$cb('API key not valid');
            }
          }
          else {
            return $c->$cb('No X-Api-Key found in header');
          }
        }
      }
    }
  );

  # Create SwaggerUI docs
  $self->plugin(
    SwaggerUI => {
      route => $self->routes()->any('api'),
      url => "/api/v1",
      title => "Barabend API Docs"
    }
  );

  # Configure the application
  $self->secrets($config->{secrets});

  #Hooks
  $self->hook( before_dispatch => sub($c) {
    my $proxy = $config->{proxy} || {};
    my $req_ip = $c->tx->remote_address;
    if ( $proxy->{ip} && $req_ip eq $proxy->{ip}){
    $c->req->url->base->scheme('https') if $c->req->headers->header('X-Forwarded-HTTPS');
    }
   });
   
   # Remove a default header
  $self->hook(after_dispatch => sub ($c) {
    $c->res->headers->access_control_allow_origin('*');
    $c->res->headers->header('Access-Control-Allow-Headers' => 'Content-Type, X-Api-Key');
    $c->res->headers->strict_transport_security('max-age=63072000; includeSubDomains');
    $c->res->headers->header('X-Content-Type-Options' => 'nosniff');
    $c->res->headers->header('X-Frame-Options' => 'DENY');
    $c->res->headers->content_security_policy("default-src 'none'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; base-uri 'self'; connect-src 'self' barabend.com; manifest-src 'self'");
    $c->res->headers->header('Access-Control-Allow-Methods' => 'GET, POST, CREATE, DELETE');
    $c->res->headers->header('Referrer-Policy' => 'no-referrer');
    $c->res->headers->header('X-XSS-Protection' => '1');
  });

  # Static files for react app
  my $static_path = path( curfile->dirname, '..', 'barabend', 'build')->to_string;
  unshift @{$self->app->static->paths}, $static_path;
  #$self->app->log->debug($static_path);
  #$self->app->log->debug( $self->dumper($self->app->static->paths) );

  # Authentication
  $self->plugin('Authentication' => {
    autoload_user   => 1,
    load_user     => \&load_user,
    validate_user => \&validate_user
  });


  # Router
  my $r = $self->routes;

  # Handle unknown API Routes which are not part of api secifiaction 
  $r->any('/api/*' => sub ($c) {
   $c->render(status => 404, json => { error => 404, message => 'Sorry, but we cannot find your endpoint'});
  });

  # Routes to react router
  $r->get('/')->to('Index#index');
  $r->get('/*')->to('Index#index');
}

1;
