#!/usr/bin/perl

use strict;
use warnings;

sub main() {
	my $filename = $ARGV[0];
	open (DATA,"<$filename") or die;
	my $num_correct = 0;
	my $num_wrong = 0;
	
	while(<DATA>) {
		chomp;
		(my $changes, my $correct, my $mispelled) = split(/\t/,$_);
		if (isCorrectSuggestion($mispelled, $correct)) {
			$num_correct++;
		} else {
			$num_wrong++;
		}
	}
	print "data:           $filename\n";
	print "number correct: $num_correct\n";
	print "number wrong:   $num_wrong\n";
	my $accuracy = $num_correct / ($num_wrong + $num_correct);
	print "accuracy:       $accuracy\n";
}

sub getAspellCorrection {
	my $mispelled = $_[0];
	my @terms = split(/\s+/,$mispelled);
	my @corrected_terms = ();
	foreach(@terms) {
		push (@corrected_terms, getAspellCorrectionForWord($_));
	}
	
	return join(" ", @corrected_terms);
}

sub getAspellCorrectionForWord {
	my $mispelled = $_[0];

	my $aspell_output = `echo "$mispelled" | aspell -a -d cs`;

	if ($aspell_output =~ "&") {

		if ($aspell_output =~ /: (.*?),/p) {
			return lc($1);
		}
	}
	return $mispelled;
	}

sub isCorrectSuggestion {
	my $mispelled = $_[0];
	my $true_correction = $_[1];
	
	my $actual_correction = getAspellCorrection($mispelled);
	
	my $result = ($actual_correction eq $true_correction);
	
	if ($result) {
		print "correct: $actual_correction suggested for $mispelled\n";
	} else {
		print "incorrect: $actual_correction suggested for $mispelled ($true_correction)\n";
	}
	
	return $result;
}

main();
