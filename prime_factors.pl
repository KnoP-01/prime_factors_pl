#!/usr/bin/perl

use strict;
use warnings;


my $debug = 0;


sub progressMsgStart
{
    my $val     = shift(@_);

    print "Start calculating prime factors of $val...\n"
}


sub progressMsgDevisor
{
    my $devisor = shift(@_);

    if ($devisor % 1000001 == 0) 
    {
        print "progress: checking prime factors > $devisor\r";
    }
    elsif ($devisor == 2)
    {
        $| = 1; # turn on auto flushing
        print "progress: checking prime factors >= 2\r";
    } 
}


sub progressMsgFound
{
    my $val     = shift(@_);
    my $devisor = shift(@_);

    print "progress: found prime factor $devisor, remainder $val\n";
}


sub progressMsgFinished
{
    my $msg         = shift(@_);
    my $saveVal     = shift(@_);
    my @result      = @_;

    if ($msg)
    {
        print "result: $saveVal has factors @result\n";
    } else {
        print "@result\n";
    }
}


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


sub foundDevisor
{
    my $refResult   = $_[0];
    my $refVal      = $_[1];
    my $devisor     = $_[2];
    my $msg         = $_[3];

    push (@$refResult, $devisor);
    $$refVal /= $devisor;
    &progressMsgFound($$refVal, $devisor) if ($msg>=2);
}


sub calcPrimeFactors
{
    my $val         = shift(@_);
    my $msg         = shift(@_); $debug=1 if ($msg>=3);
    my $saveVal     = $val;
    my @result      = qw//;

    my $devisor = 2;

    &progressMsgStart($val) if ($msg>=2);
    while ( $val>=$devisor and $val>1 )
    {
        &progressMsgDevisor($devisor) if ($msg>=2);
        while ( &isDevisible($val, $devisor) )
        {
            &foundDevisor(\@result, \$val, $devisor, $msg);
            print "result so far: @result\n" if ($debug);
        }
        if ( $devisor==2 ) { $devisor = 3; }    # after 2 check 3
        else { $devisor += 2; }                 # don't check any other even number than 2
        if ( $devisor>$val/$devisor ) { $devisor = $val; }
    }

    &progressMsgFinished($msg, $saveVal, @result);
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
    print "  --short, -s     : Print only the factors\n";
    print "  --verbose, -v   : Print more verbose messages\n";
    print "  --vverbose, -vv : Print very verbose messages\n";
    print "\n";
    print "Example: \n";
    print "\n";
    print "  prime_factors.pl 24\n";
    print "  result: 24 has factors 2 2 2 3\n";
    print "\n";
    print "  prime_factors.pl --short 36\n";
    print "  2 2 3 3\n";
}


# chose message style
my $msg = 1;
if (defined $ARGV[0] and $ARGV[0]=~m/^-/) # first argument starts with "-", assume option
{
    if ($ARGV[0]=~m/^(--short|-s)$/)     { $msg = 0; }
    if ($ARGV[0]=~m/^(--verbose|-v)$/)   { $msg = 2; }
    if ($ARGV[0]=~m/^(--vverbose|-vv)$/) { $msg = 3; }
    shift @ARGV;
}

if (not defined $ARGV[0] or $ARGV[0] !~ m/^\d+$/)
{
    &printHelp;
    exit 1;
} else {
    &calcPrimeFactors ($ARGV[0], $msg);
    exit 0;
}


1;
