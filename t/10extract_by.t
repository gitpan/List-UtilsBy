#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 14;

use Scalar::Util qw( weaken isweak );

use List::UtilsBy qw( extract_by );

# We'll need a real array to work on
my @numbers = ( 1 .. 10 );

is_deeply( [ extract_by { 0 } @numbers ], [], 'extract false returns none' );
is_deeply( \@numbers, [ 1 .. 10 ],            'extract false leaves array unchanged' );

is_deeply( [ extract_by { $_ % 3 == 0 } @numbers ], [ 3, 6, 9 ], 'extract div3 returns values' );
is_deeply( \@numbers, [ 1, 2, 4, 5, 7, 8, 10 ],                  'extract div3 removes from array' );

is_deeply( [ extract_by { $_[0] < 5 } @numbers ], [ 1, 2, 4 ], 'extract $_[0] < 4 returns values' );
is_deeply( \@numbers, [ 5, 7, 8, 10 ],                         'extract $_[0] < 4 removes from array' );

is_deeply( [ extract_by { 1 } @numbers ], [ 5, 7, 8, 10 ], 'extract true returns all' );
is_deeply( \@numbers, [],                                  'extract true leaves nothing' );

my @refs = map { {} } 1 .. 3;

weaken $_ for my @weakrefs = @refs;

is_deeply( [ extract_by { !defined $_ } @weakrefs ], [], 'extract undef refs returns nothing yet' );
is( scalar @weakrefs, 3,                                 'extract undef refs leaves array unchanged' );
ok( isweak $weakrefs[0], "extract_by doesn't break weakrefs" );

undef $refs[0];

is_deeply( [ extract_by { !defined $_ } @weakrefs ], [ undef ], 'extract undef refs yields an undef' );
is( scalar @weakrefs, 2,                                        'extract undef refs removes from array' );
ok( isweak $weakrefs[0], "extract_by still doesn't break weakrefs" );
