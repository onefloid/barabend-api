package Barabend::Auth::Util;

use Crypt::Digest::SHA3_224;
use Mojo::Util qw(secure_compare);
use Mojo::JWT;

use Try::Tiny;

use Exporter 'import';

our @EXPORT_OK = qw/load_user validate_user/;

sub load_user {
    my ($c, $uid) = @_;
    my $user = $c->schema->resultset('User')->find({ user_id => $uid});

    if ($user){
      my $user_id = $user->user_id;
      my $role_id = $user->role->role_id;

      #$c->app->log->debug("role_id: $role_id");

      my $claim_data = {
          user_id => $user_id,
          role_id => $role_id
      };
      
      # Valid for 1 hour
      my $expires = time + 3600;

      my $jwt = Mojo::JWT->new(claims => $claim_data, secret => $c->app->secrets->[0], expires => $expires)->encode;

      return { 
          user_name => $user->user_name,
          user_id => $user_id,
          role_id => $role_id,
          'X-Api-Key' => $jwt
        };
    }

    return undef;
}

sub validate_user {
    my ($c, $username, $password, $extradata) = @_;
    my $user = $c->schema->resultset('User')->find({ user_name => $username});

    return undef unless $user;

    my $digest = Crypt::Digest::SHA3_224->new;
    $digest->add($password);
    my $entered_password_digest  = $digest->b64digest;

    return $user->user_id if secure_compare( $user->password_hash, $entered_password_digest);

    return undef;
}

1;