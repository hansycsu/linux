#!/usr/bin/perl
use strict;
use warnings;

open FILE, $ARGV[0] or die "$!\n";

my @cases;        # array of hash stores result
my $readNextLine; # bool to flow control
my $num;          # store the number part of case
my $prevLine;     # store previous line for potentially using
while (my $line = <FILE>) {

  if (!$readNextLine) {
    # if 'case' found
    if ($line =~ /^\s*(case (\d+).*)/) {
      my $str = $1;
      $num = $2;

      # if comment found, extract
      if ($str =~ m#//(.*)#) {
        my $comment = $1;

        # if the comment is useless, search next line
        if ($comment =~ /^\s*PBox/) {
          $readNextLine = 1;
          next;
        }

        my $hashData = {index => $num, comment => $comment};
        push @cases, $hashData;

      # if comment not found, search next line
      } else {
        $readNextLine = 1;
        next;
      }
    }
  }

  # read the line below 'case'
  if ($readNextLine) {

    # if comment found, extract
    if ($line =~ m#//(.*)#) {
      my $comment = $1;
      my $hashData = {index => $num, comment => $comment};
      push @cases, $hashData;

    # if comment not found, check previous line
    } else {
      if ($prevLine =~ m#//(.*)#) {
        my $comment = $1;
        my $hashData = {index => $num, comment => $comment};
        push @cases, $hashData;
      }
    }

    $readNextLine = 0;
  }

  $prevLine = $line;
}
close(FILE);

# remove redundant characters in comment string
for my $elem (@cases) {
  $elem->{comment} =~ s/[\r\n]//g;
  $elem->{comment} =~ s/\s+$//;
  $elem->{comment} =~ s/^\s+//;
}

for my $elem (@cases) {
  print "$elem->{index}\t$elem->{comment}\n";
}
