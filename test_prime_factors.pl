#!/usr/bin/perl

use strict;
use warnings;

push @INC , ".";
require "prime_factors.pl";

use Time::HiRes qw/gettimeofday tv_interval/;

# valid values for $debug are the valid values of $msg in prime_factors.pl
my $debug = 0;

sub test_primes
{
    my $val2factor      = shift(@_);
    my @expectedResult  = qw//;
    @expectedResult     = @_ if @_;

    print "\nexpect: $val2factor has factors @expectedResult\n" if $debug;

    my $t0 = [gettimeofday] if $debug;
    my @primesResult   = &calcPrimeFactors($val2factor, $debug);
    print "time: " . tv_interval ( $t0, [gettimeofday]) . "\n" if $debug;

    if ( @primesResult ne @expectedResult ) # evaluation
    {
        print "&calcPrimeFactors($val2factor): does not return @expectedResult, but: <@primesResult>\n";
        return 1;
    }
    return 0;
}


if ( defined $ARGV[0] and ( $ARGV[0]>=0 and $ARGV[0]<=3 ) )
{
    $debug=$ARGV[0]
}
print "\nStart tests...\n--------------\n";
my $t0 = [gettimeofday] if $debug;
my $testFailed = 0;


#test 0
my $val2factor=0;
my @expectedResult=qw/ /;
$testFailed += &test_primes($val2factor, @expectedResult);

#test 1
$val2factor=1;
@expectedResult=qw/ /;
$testFailed += &test_primes($val2factor, @expectedResult);


#test 2
$val2factor=2;
@expectedResult=qw/2/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test 3
$val2factor=3;
@expectedResult=qw/3/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test 4
$val2factor=4;
@expectedResult=qw/2 2/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test 5
$val2factor=5;
@expectedResult=qw/5/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test 6
$val2factor=6;
@expectedResult=qw/3 2/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test 7
$val2factor=7;
@expectedResult=qw/7/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test 24
$val2factor=24;
@expectedResult=qw/2 2 2 3/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test 123
$val2factor=123;
@expectedResult=qw/3 41/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test big number
$val2factor=2*3*5*7*13*17*1117;
@expectedResult=qw/2 3 5 7 13 17 1117/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test big number
$val2factor=297325219968;
@expectedResult=qw/2 2 2 2 2 2 2 3 3 3 3 3 7 7 7 29 31 31/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test big number
$val2factor=72570684380103;
@expectedResult=qw/3 3 3 3 7 13 23 31 43 53 73 83/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test big number
$val2factor=89213157642;
@expectedResult=qw/2 3 7 139 15281459/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test big number with some really big factors
$val2factor=234879500555555;
@expectedResult=qw/5 4937 9515069903/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test really big number with some really big factors
$val2factor=1151542165183435111;
@expectedResult=qw/1048127 1048129 1048217/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test really big number with some really big factors
$val2factor=2151542165183435111;
@expectedResult=qw/89 25784303 937571633/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test really big number with some really big factors
$val2factor=11515421651834351117;
@expectedResult=qw/2551 4514081400170267/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test search for an edge case
$val2factor=1000113004255053391;
@expectedResult=qw/1000037 1000037 1000039/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test search for an edge case
$val2factor=6067231252638717023;
@expectedResult=qw/1019 1021 1031 1033 2339 2341/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test search for an edge case
$val2factor=34436317761268877;
@expectedResult=qw/47 157 457 1021 10001779/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test search for an edge case
$val2factor=900002340001517;
@expectedResult=qw/30000037 30000041/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test search for an edge case
$val2factor=2500183800062203;
@expectedResult=qw/50000017 50003659/;
$testFailed += &test_primes($val2factor, @expectedResult);


#test search for an edge case
$val2factor=1500111620135383;
@expectedResult=qw/30000037 50003659/;
$testFailed += &test_primes($val2factor, @expectedResult);


print "\n--------------\nTests finished\n";
print "$testFailed test(s) failed!\n" if $testFailed;
print "time total: " . tv_interval ( $t0, [gettimeofday]) . "\n" if $debug;

1;
