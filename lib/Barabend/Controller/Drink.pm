package Barabend::Controller::Drink;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Barabend::Model::Schema;
use Try::Tiny;

sub read ($self) {

  my $id = $self->param('id') || '';

  my @results;
  my $has_errors = 0;
  try{
    if($id){
      @results = $self->schema->resultset('Drink')->search({ drink_id => $id})
    }
    else{
      @results = $self->schema->resultset('Drink')->search(undef, { distinct => 1 });
    }
  }
  catch{
    $has_errors=1;
  };
  
  if ($has_errors || scalar(@results) == 0 ){
    $self->render_error(status => 404, message => 'Sorry, but we cannot find your drink' );
    return;
  }

  my @drinks = map($_->TO_JSON, @results);

  $self->render(openapi => \@drinks);

}

1;