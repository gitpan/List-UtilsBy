#!/usr/bin/perl -w

use strict;

use Test::More tests => 7;

use List::UtilsBy qw( sort_by );

is_deeply( [ sort_by { } ], [], 'empty list' );

is_deeply( [ sort_by { $_ } "a" ], [ "a" ], 'unit list' );

is_deeply( [ sort_by { my $ret = $_; undef $_; $ret } "a" ], [ "a" ], 'localises $_' );

is_deeply( [ sort_by { $_ } "a", "b" ], [ "a", "b" ], 'identity function no-op' );
is_deeply( [ sort_by { $_ } "b", "a" ], [ "a", "b" ], 'identity function on $_' );

is_deeply( [ sort_by { $_[0] } "b", "a" ], [ "a", "b" ], 'identity function on $_[0]' );

# list reverse on a single element is a no-op; scalar reverse will swap the
# characters. This test also ensures the correct context is seen by the function
is_deeply( [ sort_by { reverse $_ } "az", "by" ], [ "by", "az" ], 'reverse function' );
