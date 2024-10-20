package Barabend::Plugin::Error;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {

    $app->helper('render_error' => sub ($self, %params) {
        my $message = $params{message} || 'Error';
        my $status  = $params{status} || 400;

        my $error_document = {
            errors => [
                {
                    message => $message,
                    path => $self->req->url->to_string
                }
            ],
            status => $status
        };

        $self->render(openapi => $error_document, status => $status);

        return;
    
    });
}

1;