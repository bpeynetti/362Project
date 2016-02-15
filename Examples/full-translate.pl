#!/usr/local/bin/perl -w
use strict;

my $memaddr = 0x2000;
my $membuf = "";

$_ = <STDIN>;             # strip the first line of the file
my @lines = <STDIN>;
foreach $_ (@lines)
  {

#look for preprocessor commands
if(/\s*\S+\s+;\s+(.*)\n/)
  {
    print "\#" . $1 . "\n"; 
  }
#look for valid instructions
elsif(/\s*\d+\s+([0-9a-fA-F]{8})\s+([0-9a-fA-F]{8})\s+(.*)\n/)
  {
    print $1 . " \/ ". $2 ."\;\t\#" .$3 ."\n";
  }
#look for valid hex instructions
elsif(/\s*\d+\s+([0-9a-fA-F]{8})\s+([0-9a-fA-F]{2,8})\s+(.*)/)
  {
      print $1 . " / " . $2 . ";\t\#mem --". $3 . "\n";
  }
#look for valid halfword memory information
elsif(/.*\.half\s+(\-*\d+)\n/)
  {
      my $val = sprintf("%0.4x",$1); 
      $val =~ /.*([0-9a-fA-F]{4})/;
      $membuf .= $1;
      $memaddr += 2;

#      printf("%0.8x \/ %0.8x\;\t\#mem  \n", $memaddr-4, $1 );       

      if(!($memaddr % 4))
      {
          $membuf = sprintf("%0.8x \/ %s\;\t\#mem  --[hw0][hw1]\n", $memaddr-4, $membuf );
	  print $membuf;
	  $membuf = "";
      }
  }
#otherwise unrecognized lines
else
  {
      print "\##??## " . $_;
  }
}

## Flush the buffer if there's any remaining data to be written
if($membuf ne "")
{
    printf("%0.8x \/ %s\;\t\#mem\n", $memaddr-4, $membuf );
}









