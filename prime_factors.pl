#!/usr/bin/perl

use strict;
use warnings;
# use bigint;


my $debug = 0;


sub progressMsgStart
{
    print "Start calculating prime factors of $_[0]...\n";
    return 0;
    # my $val     = shift(@_);

    # print "Start calculating prime factors of $val...\n";
}


sub progressMsgDevisor
{
    if ($_[0] % 1000001 == 0) 
    {
        print "progress: checking prime factors > $_[0]\r";
    }
    elsif ($_[0] == 2)
    {
        $| = 1; # turn on auto flushing
        print "progress: checking prime factors >= 2\r";
    } 
    return 0;
    # my $devisor = shift(@_);

    # if ($devisor % 1000001 == 0) 
    # {
    #     print "progress: checking prime factors > $devisor\r";
    # }
    # elsif ($devisor == 2)
    # {
    #     $| = 1; # turn on auto flushing
    #     print "progress: checking prime factors >= 2\r";
    # } 
}


sub progressMsgFound
{
    print "progress: found prime factor " . shift(@_) . ", remainder " . shift(@_) . "\n";
    print "result so far: @_\n" if ($debug);
    return 0;
    # my $devisor = shift(@_);
    # my $val     = shift(@_);
    # my @result  = @_;

    # print "progress: found prime factor $devisor, remainder $val\n";
    # print "result so far: @result\n" if ($debug);
}


sub progressMsgFinished
{
    if (shift(@_))
    {
        print "result: ".shift(@_)." has factors @_\n";
    } else {
        print "@_\n";
    }
    return 0;
    # my $verbosity   = shift(@_);
    # my $saveVal     = shift(@_);
    # my @result      = @_;

    # if ($verbosity)
    # {
    #     print "result: $saveVal has factors @result\n";
    # } else {
    #     print "@result\n";
    # }
}


sub isDevisible
{
    if ($_[0] % $_[1] == 0) 
    {
        return 1;
    }
    return 0;
    # my $val         = shift(@_);
    # my $devisor     = shift(@_);

    # if ($val % $devisor == 0) 
    # {
    #     return 1;
    # }
    # return 0;
}


# pushes $devisor to @result
# manipulates $val
# give messages
sub foundDevisorAction
{
    my $refResult   = $_[0];
    my $refVal      = $_[1];

    push (@$refResult, $_[2]);
    $$refVal /= $_[2];
    &progressMsgFound($_[2], $$refVal, @$refResult) if ($_[3]>=2);
    return 0;
    # my $refResult   = $_[0];
    # my $refVal      = $_[1];
    # my $devisor     = $_[2];
    # my $verbosity   = $_[3];

    # push (@$refResult, $devisor);
    # $$refVal /= $devisor;
    # &progressMsgFound($devisor, $$refVal) if ($verbosity>=2);
}


sub calcPrimeFactors
{
    my $val         = shift(@_);
    my $verbosity   = shift(@_); $debug=1 if ($verbosity>=3);
    my $saveVal     = $val;
    my @result      = qw//;


    &progressMsgStart($val) if ($verbosity>=2);

    my $devisor = 2;
    if ( $val>=$devisor and $val>1 )
    {
        &progressMsgDevisor($devisor) if ($verbosity>=2);
        while ( &isDevisible($val, $devisor) )
        { &foundDevisorAction(\@result, \$val, $devisor, $verbosity); }
    }

    $devisor = 3;
    if ( $val>=$devisor and $val>1 )
    {
        &progressMsgDevisor($devisor) if ($verbosity>=2);
        while ( &isDevisible($val, $devisor) )
        { &foundDevisorAction(\@result, \$val, $devisor, $verbosity); }
    }

    $devisor = 5;
    if ( $val>=$devisor and $val>1 )
    {
        &progressMsgDevisor($devisor) if ($verbosity>=2);
        while ( &isDevisible($val, $devisor) )
        { &foundDevisorAction(\@result, \$val, $devisor, $verbosity); }
    }

    $devisor = 7;
    while ( $val>=$devisor and $val>1 )
    {
        # xx7
        &progressMsgDevisor($devisor) if ($verbosity>=2);
        while ( &isDevisible($val, $devisor) )
        { &foundDevisorAction(\@result, \$val, $devisor, $verbosity); }
        $devisor += 2;
        # xx9
        &progressMsgDevisor($devisor) if ($verbosity>=2);
        while ( &isDevisible($val, $devisor) )
        { &foundDevisorAction(\@result, \$val, $devisor, $verbosity); }
        $devisor += 2;
        # xx1
        &progressMsgDevisor($devisor) if ($verbosity>=2);
        while ( &isDevisible($val, $devisor) )
        { &foundDevisorAction(\@result, \$val, $devisor, $verbosity); }
        $devisor += 2;
        # xx3
        &progressMsgDevisor($devisor) if ($verbosity>=2);
        while ( &isDevisible($val, $devisor) )
        { &foundDevisorAction(\@result, \$val, $devisor, $verbosity); }
        $devisor += 4; # don't check xx5'
        if ( $devisor>$val/$devisor ) { $devisor = $val; }
    }

    &progressMsgFinished($verbosity, $saveVal, @result);
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
my $verbosity = 1;
if (defined $ARGV[0] and $ARGV[0]=~m/^-/) # first argument starts with "-", assume option
{
    if ($ARGV[0]=~m/^(--short|-s)$/)     { $verbosity = 0; }
    if ($ARGV[0]=~m/^(--verbose|-v)$/)   { $verbosity = 2; }
    if ($ARGV[0]=~m/^(--vverbose|-vv)$/) { $verbosity = 3; }
    shift @ARGV;
}

if (not defined $ARGV[0] or $ARGV[0] !~ m/^\d+$/)
{
    &printHelp;
    exit 1;
} else {
    &calcPrimeFactors ($ARGV[0], $verbosity);
    exit 0;
}


1;
