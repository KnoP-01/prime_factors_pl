#!/usr/bin/perl

use strict;
use warnings;

push @INC , ".";
require "prime_factors.pl";

# valid values for $debug are the valid values of $msg in prime_factors.pl
my $debug = 0;

sub test_primes
{
    my $val2factor      = shift(@_);
    my @expectedResult  = qw//;
    @expectedResult     = @_ if @_;

    print "\nexpect: $val2factor has factors @expectedResult\n" if $debug;

    my @primesResult   = &calcPrimeFactors($val2factor, $debug);
    if ( @primesResult ne @expectedResult )
    {
        print "&calcPrimeFactors($val2factor): does not return @expectedResult, but: <@primesResult>\n";
    }
}


if ( defined $ARGV[0] and ( $ARGV[0]>=0 and $ARGV[0]<=3 ) )
{
    $debug=$ARGV[0]
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
@expectedResult=qw/3 2/;
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


#test big number with some really big factors
$val2factor=234879500555555;
@expectedResult=qw/5 4937 9515069903/;
&test_primes($val2factor, @expectedResult);


#test really big number with some really big factors
$val2factor=1151542165183435111;
@expectedResult=qw/1048127 1048129 1048217/;
&test_primes($val2factor, @expectedResult);


#test really big number with some really big factors
$val2factor=2151542165183435111;
@expectedResult=qw/89 25784303 937571633/;
&test_primes($val2factor, @expectedResult);


#test really big number with some really big factors
$val2factor=11515421651834351117;
@expectedResult=qw/2551 4514081400170267/;
&test_primes($val2factor, @expectedResult);


print "\n--------------\nTests finished\n";

1;
