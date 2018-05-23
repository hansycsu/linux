#!/bin/perl
# List all PBox members
use List::Util qw(any);
open FILE, 'zoom100_pbox.txt';

my @arr;
while ($line = <FILE>) {
  if ($line =~ /PBox\[p\]\.(\w+)\[/ ) {
    # Same member only be added once
    unless (any { $1 eq $_ } @arr) {
      push @arr, $1;
    }
  }
}

for my $i (@arr) {
  print "$i\n";
}
