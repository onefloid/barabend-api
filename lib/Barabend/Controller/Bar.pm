package Barabend::Controller::Bar;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Barabend::Model::Schema;
use Try::Tiny;

sub random ($self) {
  $self->param('id' => 'random'); 
  $self->read()
}

sub create {

  my $self = shift->openapi->valid_input or return;

  unless ( $self->is_authorized( 'minimum_required_role' => 2 ) ){
    $self->render_error( 
      message => 'Oops. You are not authorized to update data for bars!',
      status => 403
    );

    return;
  }

  my $document = $self->req->json;
  my $bar_id = $document->{bar_id};

  unless ($bar_id){
    $self->render_error( 
      message => 'Oops. Updating your document is not possible. Please pass an bar_id!',
      status => 404
    );
    return;
  }

  my $has_error = '';
  try{
    my $new_bar = $self->schema->resultset('Bar')->create($document);
  }
  catch{
    $self->app->log->debug($_);
    $self->render_error( 
      message => 'Oops. Updating your document is not possible. Maybe it is not valid!',
      status => 400
    );
    $has_error = 1;
  };
  return if $has_error;
  
  $self->render( openapi => $document, status => 201);

}

sub read {

  my $self = shift->openapi->valid_input or return;

  my $id = $self->param('id') || '';
  
  my $search = $self->req->query_params->to_hash;
  #$self->app->log->debug('Params: ' . $self->dumper($search));

  my @results;
  my $has_errors = 0;
  try{
    if ($id eq 'random'){
      @results = $self->schema->resultset('Bar')->search(
        {},
        {
          order_by => ['RAND()'] ,
          rows => 1,
        },
      )
    }
    elsif($id){
      @results = $self->schema->resultset('Bar')->search({ bar_id => $id})
    }
    else{
      @results = $self->schema->resultset('Bar')->search($search);
    }
  }
  catch{
    $has_errors=1;
  };

  if ($has_errors || scalar(@results) == 0 ){
    $self->render_error(status => 404, message => 'Sorry, but we cannot find your bar' );
    return;
  }

  my @bars = map($_->TO_JSON, @results);

  $self->render(openapi => \@bars);

}

sub update {

  my $self = shift->openapi->valid_input or return;

  unless ( $self->is_authorized( 'minimum_required_role' => 2 ) ){
    $self->render_error( 
      message => 'Oops. You are not authorized to update data for bars!',
      status => 403
    );

    return;
  }
  my $document = $self->req->json;
  my $bar_id = delete $document->{bar_id};

  $self->app->log->debug("bar_id: $bar_id");
  
  unless ($bar_id){
    $self->render_error( 
      message => 'Oops. Updating your document is not possible. Please pass an bar_id!',
      status => 404
    );
    return;
  }

  my $has_error = '';
  try{
    my $results = $self->schema->resultset('Bar')->find($bar_id)->update($document);
  }
  catch{
    $self->app->log->debug($_);
    $self->render_error( 
      message => 'Oops. Updating your document is not possible. Maybe it is not valid!',
      status => 400
    );
    $has_error = 1;
  };
  return if $has_error;
  
  $document->{bar_id} = $bar_id;
  $self->render( openapi => $document);

}

sub delete {
  my $self = shift->openapi->valid_input or return;

  my $document = $self->req->json;
  my $bar_id = $document->{bar_id};

  unless ($bar_id){
    $self->render_error( 
      message => 'Oops. Deleting your document is not possible. Please pass an bar_id!',
      status => 404
    );
    return;
  }

  my $has_error = '';
  try{
    $self->schema->resultset('Bar')->find($bar_id)->delete;
  }
  catch{
    $self->app->log->debug($_);
    $self->render_error( 
      message => 'Oops. Updating your document is not possible. Maybe it is not valid!',
      status => 400
    );
    $has_error = 1;
  };
  return if $has_error;

  $self->render( openapi => $document);
}

1;