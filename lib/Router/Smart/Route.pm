package Router::Smart::Route;
use strict;
use warnings;

use Scalar::Util qw(weaken);
use Router::Smart::Util;

sub new {
    my ($class, $parent, $pattern, $destination, $opts) = @_;
    my $self = bless {
        parent      => $parent,
        pattern     => $pattern,
        destination => $destination,
        options     => $opts,
    }, $class;
    weaken($self->{parent});
    return $self;
}

sub route {
    my $self  = shift;
    my ($pattern, $dest, $opts) = Router::Smart::Util::parse(@_);
    my $p = $self->{pattern}     || "";
    my $d = $self->{destination} || {};
    my $o = $self->{options}     || {};

    $pattern  = $p.$pattern;
    $dest     = {%$d, %$dest};
    $opts     = {%$o, %$opts};
    $self->{parent}->add_route($pattern, $dest, $opts);
}

sub build_pattern {
    my $self = shift;
    my $constraints   = $self->{options}{constraints} || {};
    my $default_const = $self->{parent}{constraints}  || {};
    my @captures;
    my $pattern_re = $self->{pattern};

    $pattern_re =~ s!
        :([A-Za-z0-9_]+)  | # /blog/:year
        \*([A-Za-z0-9_]+) | # /blog/*year
        ([^{:*]+)           # normal string
    !
        if ($1) {
            push @captures, $1;
            $constraints->{$1} ? "($constraints->{$1})" : $default_const->{$1} ? "($default_const->{$1})" :"([^/]+)";
        } elsif ($2) {
            push @captures, $2;
            "(.+)";
        } else {
            quotemeta($3);
        }
    !gex;
    $self->{pattern_re} = qr/^$pattern_re$/;
    $self->{captures}   = \@captures;
    return $self;
}

1;
