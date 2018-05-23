#!/bin/perl

my $argc = $#ARGV + 1;
if ($argc == 0) {
  print 'No file specified.';
  exit;
}

print "Number of args: $argc\n";
print '=' x 30 . "\n";

my $lineCnt = 0;

# calculate max length fo file name
my $nameMaxLength;
for my $file (@ARGV) {
  my $fnameL = length($file);
  if ($fnameL > $nameMaxLength) {
    $nameMaxLength = $fnameL;
  }
}

# open files, count and print number of lines
my $addedSpace = 3;
for my $file (@ARGV) {
  open FILE, $file;
  my @fileStream = <FILE>;
  close(FILE);

  my $lines = $#fileStream + 1;
  my $width = $nameMaxLength + $addedSpace;
  printf("%-" . $width . "s %d\n", $file, $lines);
  $lineCnt += $lines;
}

print '=' x 30 . "\n";

print "Total lines: $lineCnt\n";
