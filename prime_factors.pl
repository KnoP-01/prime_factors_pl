#!/usr/bin/perl

use strict;
use warnings;


sub isDevisible
{
    my $val         = shift(@_);
    my $devisor     = shift(@_);

    if ($val % $devisor == 0) 
    {
        return 1;
    }
    return 0;
}


sub primes
{
    my $val         = shift(@_);
    my $shortMsg    = shift(@_);
    my $saveVal     = $val;
    my @result      = qw//;

    my $devisor = 2;
    print "Start calculating...\n";

    while ($val > 1)
    {
        while ( &isDevisible($val, $devisor) )
        {
            push (@result, $devisor);
            print "progress: $devisor \n" if not $shortMsg;
            $val /= $devisor;
        }
        $devisor+=1;
    }

    if ($shortMsg)
    {
        print "@result\n";
    } else {
        print "result: $saveVal has factors @result\n";
    }

    return @result;
}


if ($0 !~ m/(^|\W)prime_factors\.pl$/)
{
    # if not called from shell directly by e.g. ./prime_factors.pl...
    # return true to indicate successful execution to "require"
    return 1;
}


sub printHelp 
{
    print "Usage: prime_factors.pl [Option] N\n";
    print "  Prints the prime factors of N.\n";
    print "  N must be an integer without thousand separators!\n";
    print "\n";
    print "  Option:\n";
    print "  --short, -s: Print only the factors\n";
    print "\n";
    print "Example: \n";
    print "\n";
    print "  prime_factors.pl 24\n";
    print "  result: 24 has factors 2 2 2 3\n";
    print "\n";
    print "  prime_factors.pl --short 36\n";
    print "  2 2 3 3\n";
}


# short output?
my $shortMsg = 0;
if (defined $ARGV[0] and $ARGV[0]=~m/^(--short|-s)$/)
{
    # --short or -s as first parameter: short output!
    $shortMsg = 1;
    shift @ARGV;
}

if (not defined $ARGV[0] or $ARGV[0] !~ m/^\d+$/)
{
    &printHelp;
    exit 1;
} else {
    # calculate prime factors
    &primes ($ARGV[0], $shortMsg);
    exit 0;
}


1;
