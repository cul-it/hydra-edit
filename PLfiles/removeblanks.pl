#!/usr/bin/perl

open(DATA, "chlaissuesIDs71.txt") or die "Couldn't open file chlapids.txt, $!";

while(<DATA>) {
   chomp $_;
   if (length($_) > 4 and $_ !~ m/members/) {
      print $_ . "\n";
    #  print $tupac[1] . "\n";
#   }
#   print "nope\n";
  } else {
#   print $_;
#   print "nope\n";
  } 
}
