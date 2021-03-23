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


sub progressMsgStart
{
    my $val     = shift(@_);
    print "Start calculating devisors of $val...\n"
}


sub progressMsgDevisor
{
    my $devisor = shift(@_);
    if ($devisor % 1000000 == 0) 
    {
        $| = 1; # turn on auto flushing
        print "\rprogress: checking devisors > $devisor";
    }
    elsif ($devisor == 2)
    {
        print "progress: checking devisors >= 2\n";
    } 
}


sub progressMsgFound
{
    my $val     = shift(@_);
    my $devisor = shift(@_);
    # turn off auto flushing
    if ($|) { print "\n"; $| = 0; }
    print "progress: found devisor $devisor, remainder $val\n";
}


sub primes
{
    my $val         = shift(@_);
    my $msg         = shift(@_); if (not defined $msg) { $msg = 1; }
    my $saveVal     = $val;
    my @result      = qw//;


    my $devisor = 2;

    &progressMsgStart($val) if ($msg==2);
    while ( $val>=$devisor )
    {
        &progressMsgDevisor($devisor) if ($msg==2);
        while ( &isDevisible($val, $devisor) )
        {
            push (@result, $devisor);
            $val /= $devisor;
            &progressMsgFound($val, $devisor) if ($msg==2);
        }
        $devisor+=1;
    }
    # turn off auto flushing
    if ($|) { print "\n"; $| = 0; }

    if ($msg)
    {
        print "result: $saveVal has factors @result\n";
    } else {
        print "@result\n";
    }

    return @result;
}


if ($0 !~ m/\bprime_factors\.pl$/)
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
    print "  --short, -s    : Print only the factors\n";
    print "  --verbose, -v  : Print more verbose messages\n";
    print "\n";
    print "Example: \n";
    print "\n";
    print "  prime_factors.pl 24\n";
    print "  result: 24 has factors 2 2 2 3\n";
    print "\n";
    print "  prime_factors.pl --short 36\n";
    print "  2 2 3 3\n";
}


# chose messages
my $msg = 1;
if (defined $ARGV[0] and $ARGV[0]=~m/^(--short|-s)$/)
{
    # --short or -s as first parameter: short output!
    $msg = 0;
    shift @ARGV;
}
if (defined $ARGV[0] and $ARGV[0]=~m/^(--verbose|-v)$/)
{
    # --verbose or -v as first parameter: verbose output!
    $msg = 2;
    shift @ARGV;
}

if (not defined $ARGV[0] or $ARGV[0] !~ m/^\d+$/)
{
    &printHelp;
    exit 1;
} else {
    # calculate prime factors
    &primes ($ARGV[0], $msg);
    exit 0;
}


1;
