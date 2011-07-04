use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Router::Smart;
use Data::Dumper;

my $r = Router::Smart->new(constraints => {
        id => qr/[0-9]+/,
    });
$r->route('/' => { controller => 'Root', action => 'index' });
$r->route('/user/:id' => { controller => 'User', action => 'index' });
$r->route('/post' => 'Post#index') # postもroutesに追加
    ->route('/:id'   => '#hyoushi')
    ->route('/about' => '#about');

# routes に追加しない
my $name = $r->way('/:name' => 'Author', constraints => { name => qr/hisaichi|hisada/ });
$name->route('/about' => '#about');

# $r->match($psgi_env);
print Dumper $r;
