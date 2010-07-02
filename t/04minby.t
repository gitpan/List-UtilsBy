#!/usr/bin/perl -w

use strict;

use Test::More tests => 8;

use List::UtilsBy qw( min_by );

is_deeply( [ min_by {} ], [], 'empty list yields empty' );

is_deeply( ( scalar min_by { $_ } 10 ), 10, 'unit list yields value in scalar context' );
is_deeply( [ min_by { $_ } 10 ], [ 10 ], 'unit list yields unit list value' );

is_deeply( ( scalar min_by { $_ } 10, 20 ), 10, 'identity function on $_' );
is_deeply( ( scalar min_by { $_[0] } 10, 20 ), 10, 'identity function on $_[0]' );

is_deeply( ( scalar min_by { length $_ } "a", "ccc", "bb" ), "a", 'length function' );

is_deeply( ( scalar min_by { length $_ } "a", "ccc", "bb", "e" ), "a", 'ties yield first in scalar context' );
is_deeply( [ min_by { length $_ } "a", "ccc", "bb", "ddd", "e" ], [ "a", "e" ], 'ties yield all minimal in list context' );
