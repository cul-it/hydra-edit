#!/bin/bash/perl

use strict;
use warnings;

my $filename = $ARGV[0] . "/bol". $ARGV[0] ."_johnAug18_dims.xml";
open (my $fh, $filename)
  or die "Could not open file '$filename' $!";
my $newfile = "temp.xml";
open(my $out, '>', $newfile) or die "Unable to open '$newfile' for write: $!";

while (my $row = <$fh>) {
   if ($row =~ /\"<\/P/) {
     print "match \n";
     $row =~ s/\"<\/P/<\/P/;
   }
   print $out "$row"
}
close $fh;
close $out;

rename $newfile, $filename or die "unable to rename '$newfile' to '$filename': $!";
