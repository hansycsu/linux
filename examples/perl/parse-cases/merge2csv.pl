#!/usr/bin/perl
use strict;
use warnings;

open FILE1, 'Bindex1.txt';
open FILE2, 'Bindex2.txt';
open CSV, '>bindex.csv';

# =============================================================================
# Read files to hash variable %bindex1 & %bindex2
# =============================================================================
my %bindex1;
while (my $line = <FILE1>) {
  if ($line =~ m@^case (\d+):\s*=>\s*(\d*)\s*(?://\s*(.*))?@) {
    my $index = $1;
    my $pic = $2 ? $2 : 0;
    my $comment = $3 ? $3 : '';
    $bindex1{$index} = {pic => $pic, comment => $comment};
  }
}

my %bindex2;
while (my $line = <FILE2>) {
  if ($line =~ m@^case (\d+):\s*//\s*(.*)@) {
    my $index = $1;
    my $comment = $2 ? $2 : '';
    $bindex2{$index} = {comment => $comment};
  }
}

# =============================================================================
# Merge %bindex1 & %bindex2 to %output
# =============================================================================

# hash of hash: %output
#   $output{$key}{pic}
#   $output{$key}{comment1}
#   $output{$key}{comment2}
my %output;

while ((my $key, my $value) = each %bindex1) {
  my $pic = $bindex1{$key}{pic};
  my $comment1 = $bindex2{$key}{comment};
  my $comment2 = $bindex1{$key}{comment};
  $output{$key} = {pic => $pic, comment1 => $comment1, comment2 => $comment2};
}

while ((my $key, my $value) = each %bindex2) {
  unless (exists $output{$key}) {
    my $pic = $bindex1{$key}{pic};
    my $comment1 = $bindex2{$key}{comment};
    my $comment2 = $bindex1{$key}{comment};
    $output{$key} = {pic => $pic, comment1 => $comment1, comment2 => $comment2};
  }
}

# =============================================================================
# Remove CR LF and output to CSV file
# =============================================================================
for my $key (sort {$a <=> $b} keys %output) {
  my $pic = $output{$key}{pic};
  my $comment1 = $output{$key}{comment1};
  my $comment2 = $output{$key}{comment2};
  unless ($comment1) { $comment1 = '';}
  unless ($comment2) { $comment2 = '';}
  $comment2 =~ s/[\r\n]//g;
  print CSV"$key,$pic,$comment1,$comment2\n";
}

close(FILE1);
close(FILE2);
close(CSV);
