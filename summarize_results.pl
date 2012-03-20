#!/usr/bin/perl
# usage: summarize_results.pl RESULTS_FILE
# prints out summary statistics for the RESULTS_FILE

use strict;
use warnings;

sub main() {
	my $filename = $ARGV[0];
	open (DATA, "<$filename") or die;
	my $filetext = do { local $/; <DATA> };
	#my @results = $filetext =~ m/(\S+)\n.*?number correct:\s+(\S+).*?number wrong:\s+(\S+).*?accuracy:\s+(\S+)/g;
	my @results = $filetext =~ m/data:\s+(\S+)\nnumber correct:\s+(\S+)\nnumber wrong:\s+(\S+)\naccuracy:\s+(\S+)\s+/g;
	for (my $i = 0; $i < scalar(@results); $i += 4) {
		print join("\t",@results[$i..($i + 4 - 1)]) . "\n";
	}
}

main();
