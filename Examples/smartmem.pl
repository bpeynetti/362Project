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
my $memboundry = 0;

open(SRCFILE, $src);
open(DF0, "> ".$dest."0.dat");
open(DF1, "> ".$dest."1.dat");
open(DF2, "> ".$dest."2.dat");
open(DF3, "> ".$dest."3.dat");

my $addr;
my $data;
my $i = 0;
my @memory;

my @lines = <SRCFILE>;
foreach $_ (@lines){
    next if /^#/;

#   if(/\.*\.data\s+0x([0-9a-fA-F]+).*/)
#   {
#       $memboundry = hex $1;
#       print "Boundry at: " . $1 . "\n";
#   }
   if(/\s*([0-9a-fA-F]{8})\s+\/\s+([0-9a-fA-F]{2,8})\.*/)
   {
       #print $1 . " \/ ". $2 . "\n";

       $addr = (hex $1);
   #    next if ($addr < $memboundry);

       $data = $2;
 
       while($data =~ s/([0-9a-fA-F]{2})([0-9a-fA-F]*)/$2/)
       {
	   $memory[$i] = sprintf("%0.8x / %s\n", $addr ,  $1);
	   $i += 1;
	   $addr += 1;
       }

   }   

}

foreach $_ (@memory)
{
    /([0-9a-fA-F]{8})\s*\/\s*([0-9a-fA-F]{2})\.*/;
   
    $_ =  sprintf("%0.8x / %s; \n", ((hex $1)/4), $2);

    if(((hex $1) % 4) == 0)
    {
	print DF0 $_;
    }
    elsif(((hex $1) % 4) == 1)
    {
	print DF1 $_;
    }
    elsif(((hex $1) % 4) == 2)
    {
	print DF2 $_;
    }
    else
    {
	print DF3 $_;
    }   

    print $_;
}

close(SRCFILE);
close(DF0);
close(DF1);
close(DF2);
close(DF3);

}
































