package Barabend::Plugin::Auth;
use Mojo::Base 'Mojolicious::Plugin', -signatures;
use Try::Tiny;

sub register ($self, $app, $config) {

    $app->helper('is_authorized' => sub ($self, %params) {
        my $minimum_required_role = $params{'minimum_required_role'};
        return undef unless $minimum_required_role;

        #$self->app->log->debug("Minimum required role: $minimum_required_role");

        my $claims = $self->validate_api_key();

        #$self->app->log->debug("Api key: " . $self->dumper($self->req->headers->header('X-Api-Key')));
        #$self->app->log->debug("Claims: " . $self->dumper($claims));

        return undef if not defined $claims->{'role_id'};
        
        if ($claims->{'role_id'} <= $minimum_required_role){
            return 1;
        }

        return undef;
    
    });

    $app->helper('validate_api_key' => sub ($c) {
        my $api_key = $c->req->headers->header('X-Api-Key');
        
        my $claims;
        try{
            $claims = Mojo::JWT->new(secret => $c->app->secrets->[0])->decode($api_key);
        }
        catch{
            $c->app->log->debug("API key not valid: $_");
        };
        

        if ($claims){
            return $claims;
        }
        return undef;
    });
}

1;