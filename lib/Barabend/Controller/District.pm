package Barabend::Controller::District;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Barabend::Model::Schema;
use Try::Tiny;

sub read ($self) {

  my @results;
  my $has_errors = 0;
  try{
      @results = $self->schema->resultset('Bar')->search(
        undef, 
        { columns => [qw/ district /], 
          distinct => 1 }
      );
  }
  catch{
    $has_errors=1;
  };

  if ($has_errors || scalar(@results) == 0 ){
    $self->render_error(status => 404, message => 'Sorry, but we cannot find any districts');
    return;
  }

  my @districts = map($_->district, @results);

  $self->render(openapi => \@districts);

}

1;