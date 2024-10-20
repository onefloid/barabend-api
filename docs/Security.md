

# Rule 1: Every api path is public if not explicit marked as Protected
# Rule 2: Only authenticated Users can access restricted routes
# Rule 3: Every authenticated user has access to her or him personal store 
            /api/v1/users/{user_id}
             $parts->[3] != $claims->{'user_id'}
             $path->contains('/api/v1/users'
# Rule 4:Admins and editors are allowed to cud bars
    $self->is_authorized( 'minimum_required_role' => 2 )