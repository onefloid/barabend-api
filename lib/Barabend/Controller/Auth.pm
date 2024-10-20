package Barabend::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub login {
    my $self = shift->openapi->valid_input or return;

    my $credentials = $self->req->json;

    my $username = $credentials->{'user_name'};
    my $password = $credentials->{'password'};

    if ($self->authenticate($username, $password)){
      $self->render(openapi => $self->current_user, status => 200);
      return;
    }
    else{
      $self->render_error( 
      message => 'Username or password wrong!',
      status => 401
      );
      return;
    }
}

sub end_session{
    my $self = shift->openapi->valid_input or return;
    $self->logout();
    $self->render(openapi => {loggedIn => 0}, status => 200);
    return;
}

sub session_info{
    my $self = shift->openapi->valid_input or return;
    $self->render(openapi => $self->current_user, status => 200);
    return;
}

1;