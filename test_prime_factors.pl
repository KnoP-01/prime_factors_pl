#!/usr/bin/perl

use strict;
use warnings;

push @INC , ".";
require "prime_factors.pl";

my $debug = 0;

sub test_primes
{
    my $val2factor      = shift(@_);
    my @expectedResult  = qw//;
    @expectedResult     = @_ if @_;

    print "\nexpect: $val2factor has factors @expectedResult\n" if $debug;

    my @primesResult   = &primes($val2factor);
    if ( @primesResult ne @expectedResult )
    {
        print "&primes($val2factor): does not return @expectedResult, but: <@primesResult>\n";
    }
}


print "\nStart tests...\n--------------\n";


#test 0
my $val2factor=0;
my @expectedResult=qw/ /;
&test_primes($val2factor, @expectedResult);

#test 1
$val2factor=1;
@expectedResult=qw/ /;
&test_primes($val2factor, @expectedResult);


#test 2
$val2factor=2;
@expectedResult=qw/2/;
&test_primes($val2factor, @expectedResult);


#test 3
$val2factor=3;
@expectedResult=qw/3/;
&test_primes($val2factor, @expectedResult);


#test 4
$val2factor=4;
@expectedResult=qw/2 2/;
&test_primes($val2factor, @expectedResult);


#test 5
$val2factor=5;
@expectedResult=qw/5/;
&test_primes($val2factor, @expectedResult);


#test 6
$val2factor=6;
@expectedResult=qw/2 3/;
&test_primes($val2factor, @expectedResult);


#test 7
$val2factor=7;
@expectedResult=qw/7/;
&test_primes($val2factor, @expectedResult);


#test 24
$val2factor=24;
@expectedResult=qw/2 2 2 3/;
&test_primes($val2factor, @expectedResult);


#test 123
$val2factor=123;
@expectedResult=qw/3 41/;
&test_primes($val2factor, @expectedResult);


#test big number
$val2factor=2*3*5*7*13*17*1117;
@expectedResult=qw/2 3 5 7 13 17 1117/;
&test_primes($val2factor, @expectedResult);


#test big number
$val2factor=297325219968;
@expectedResult=qw/2 2 2 2 2 2 2 3 3 3 3 3 7 7 7 29 31 31/;
&test_primes($val2factor, @expectedResult);


#test big number
$val2factor=72570684380103;
@expectedResult=qw/3 3 3 3 7 13 23 31 43 53 73 83/;
&test_primes($val2factor, @expectedResult);


#test big number
$val2factor=89213157642;
@expectedResult=qw/2 3 7 139 15281459/;
&test_primes($val2factor, @expectedResult);


print "\n--------------\nTests finished\n";

1;
