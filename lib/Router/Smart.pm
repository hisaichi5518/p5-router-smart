package Router::Smart;
use 5.008_001;
use strict;
use warnings;

use Router::Smart::Util;
use Router::Smart::Route;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my %args = @_ == 1 ? %{$_[0]} : @_;
    bless {%args, routes => []}, $class;
}

sub route {
    my $self = shift;
    return $self->add_route(Router::Smart::Util::parse(@_));
}

sub way {
    my $self = shift;
    return $self->_way(Router::Smart::Util::parse(@_));
}

sub add_route {
    my $self = shift;
    my $route = $self->_way(@_)->build_pattern;
    push @{$self->{routes}}, $route;
    return $route;
}

sub _way {
    my $self = shift;
    return Router::Smart::Route->new($self, @_);
}
sub match {
    my ($self) = @_;
}



1;
__END__

=head1 NAME

Router::Smart - Perl extention to do something

=head1 VERSION

This document describes Router::Smart version 0.01.

=head1 SYNOPSIS

    use Router::Smart;
    
    my $r = Router::Smart->new(constraints => {
        id => qr/[0-9]+/,
    });
    $r->route('/' => {controller => "Root", action => "index"});
    my $user = $r->way('/user' => {controller => "User"});
    $user->route('/:id' => {action => "index"});
    $user->route('/0/test' => 'UserTest#do_test');

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< hello() >>

# TODO

=head1 DEPENDENCIES

Perl 5.8.1 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

hisaichi5518 E<lt>info[at]moe-project.comE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011, hisaichi5518. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
