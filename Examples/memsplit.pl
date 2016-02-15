#!/usr/local/bin/perl -w
use strict;

if ($#ARGV != 1) 
{
  print "usage: memsplit src dest\n";

}
else
{

my $src  = $ARGV[0];
my $dest = $ARGV[1]; 

open(SRCFILE, $src);
open(DF0, "> ".$dest."0.dat");
open(DF1, "> ".$dest."1.dat");
open(DF2, "> ".$dest."2.dat");
open(DF3, "> ".$dest."3.dat");

#my @of = { <DF0>, <DF1>, <DF2>, <DF3> };

my $addr;
my @lines = <SRCFILE>;
foreach $_ (@lines){
    next if /^#/;

   m|\s*(\S+)\s+\/\s+(\S+)\s+.*|;
    $addr = (hex $1)/4;    
    $2 =~ m|(..)(..)(..)(..).*|;
    

    my $hxval = sprintf("%0.8x", $addr);

      print DF0 $hxval . " / " . $1 . ";\n";
      print DF1 $hxval . " / " . $2 . ";\n";
      print DF2 $hxval . " / " . $3 . ";\n";
      print DF3 $hxval . " / " . $4 . ";\n";
 
    print $hxval ." / " .  $4 ." : ". $3 ." : ". $2 ." : ". $1 . "\n";
}

close(SRCFILE);
close(DF0);
close(DF1);
close(DF2);
close(DF3);

}













