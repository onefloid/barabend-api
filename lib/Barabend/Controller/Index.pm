package Barabend::Controller::Index;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub index ($self) {

  $self->reply->static('index.html');

}

1;
