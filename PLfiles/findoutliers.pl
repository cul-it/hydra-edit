#!/usr/bin/perl

open(DATA, "chlapids.txt") or die "Couldn't open file chlapids.txt, $!";

while(<DATA>) {
  $c = $_ =~ tr/_//;
  if ($c == 1 and $_ !~ m/_fs/) {
   @tupac = split /_/, $_;
   chomp $tupac[1];
   if ($tupac[1] > 1500 and $tupac[1] <= 1664 ) {
      print $_;
    #  print $tupac[1] . "\n";
   }
#   print "nope\n";
  } else {
#   print $_;
#   print "nope\n";
  } 
}
