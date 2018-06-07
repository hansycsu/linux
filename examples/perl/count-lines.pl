#!/bin/perl
# =============================================================================
# Global options
# =============================================================================
my $DELIM_SPACES = 3;
# =============================================================================

my $argc = $#ARGV + 1;
if ($argc == 0) {
  print "No file available\n";
  usage();
  exit;
}

my $lineCnt = 0;

# =============================================================================
# Calculate max length fo file name
# =============================================================================
my $nameMaxLength;
for my $file (@ARGV) {
  my $fnameL = length($file);
  if ($fnameL > $nameMaxLength) {
    $nameMaxLength = $fnameL;
  }
}

# =============================================================================
# Open files, count number of lines
# =============================================================================
my $optSort = 0;
my %lineLengthList;
for my $arg (@ARGV) {
  # if open file fail, check if it's an option
  unless (open(FILE, $arg)) {
    if ($arg eq '--sort') {
      $optSort = 1;
      next;
    } elsif ($arg eq '--help') {
      usage();
      exit;
    } else {
      print "Unknown option: $arg\n";
      usage();
      exit;
    }
  }
  my @fileStream = <FILE>;
  close(FILE);

  my $lineLn = $#fileStream + 1;
  $lineCnt += $lineLn;
  $lineLengthList{$arg} = $lineLn;
}

# =============================================================================
# Print result
# =============================================================================
# if no file in list, exit
my $numFiles = keys %lineLengthList;
unless ($numFiles) {
  print "No file available\n";
  usage();
  exit;
}

# calculate width of showing message
my $width = $nameMaxLength + $DELIM_SPACES;
print "Number of files: $numFiles\n";
splitLine('=', $width + 6);

# prepare array for printing (keys inside)
my @printArray;
if ($optSort) {
  @printArray = sort { $lineLengthList{$a} <=> $lineLengthList{$b} } keys %lineLengthList;
} else {
  @printArray = sort keys %lineLengthList;
}

# print the result
for my $file (@printArray) {
  my $lineLn = $lineLengthList{$file};
  printf("%-" . $width . "s%6d\n", $file, $lineLn);
}

splitLine('=', $width + 6);

print "Total lines: $lineCnt\n";

# =============================================================================
# Functions
# =============================================================================
sub usage {
  my @pathArr = split('/', __FILE__);
  my $_FILE = $pathArr[$#pathArr];
  print <<HERE_DOC;
Usage: $_FILE [OPTION]... FILE...
Count number of lines in FILEs.

Options:
  --sort         Sort the result by number of lines
  --help         Show this help message and exit
HERE_DOC
}

sub splitLine { # 0: char, 1: length
  print $_[0] x $_[1] . "\n";
}
