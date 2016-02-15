#!/usr/local/bin/perl -w
use strict;

$_ = <STDIN>;
my @lines = <STDIN>;
my $second;
my $comment;
foreach $_ (@lines){
    $second = "";
    $comment = "";
    if (s/\s+\S+\s+(\S+)\s+(\S+)\s+(.*)\n/$1 \/ $2\;\t\#$3\n/) {
	$second = $2;
	$comment = $3;
    }
    if ($second =~ /^(\d|a|b|c|d|e|f){1,8}?$/) {
	# These are the valid memory lines
	print $_;
    }
    else {
	# These are just comments and stuff if you want 
	# the mem file to match the listfile line for line
	#print "# $comment\n";
    }
}


