package Router::Smart::Util;
use strict;
use warnings;

use Carp ();

sub parse {
    my ($pattern, $destination, %opts) = @_;

    if (!$pattern) { Carp::croak("Can't find pattern!"); }
    if (!ref $destination) {
        my ($controller, $action) = split '#', $destination || "";
        $destination = {};
        $destination->{controller} = $controller if $controller;
        $destination->{action}     = $action     if $action;
    }
    elsif (ref $destination ne 'HASH') {
        Carp::croak("destination is non-HashRef!");
    }

    return($pattern, $destination, \%opts);
}

1;
