#!/usr/bin/env perl

use strict;
use warnings;

sub main() {
	my $filename = $ARGV[0];
    #if no filename is define, <DATA> will read the __DATA__ section at the end of the script
	open (DATA,"<$filename") or die if $filename;
    
	my ($num_correct, $num_wrong) = (0, 0);
	
	while(<DATA>) {
		chomp;
        #$_ is the default second param for split
        #put 'my' once before is enough
		my ($changes, $correct, $mispelled) = split(/\t/);

        #well, that's weird
		(isCorrectSuggestion($mispelled, $correct))?$num_correct++:$num_wrong++;
	}
    
	my $accuracy = $num_correct / ($num_wrong + $num_correct);
    $filename ||= '__DATA__';
    print <<WHATEVER;
data:           $filename
number correct: $num_correct
number wrong:   $num_wrong
accuracy:       $accuracy
WHATEVER
}

sub getAspellCorrection {
	my $mispelled = $_[0];
	my @terms = split(/\s+/,$mispelled);
    
    #return is on last statements
	join " ", (map {getAspellCorrectionForWord($_)} @terms);
}

sub getAspellCorrectionForWord {
	my $mispelled = $_[0];

	my $aspell_output = `echo "$mispelled" | aspell -a -d cs`;
    return lc($1) if ($aspell_output =~ "&") && ($aspell_output =~ /: (.*?),/p);

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


__DATA__
1	sentinelovou uzlinu	sentinelovou uzliunu
1	Raynaudova fenoménu	Raymaudova fenoménu
1	Nobelovou cenou	Nobepovou cenou
1	kalcium karbonátu	kalcium karbnoátu
0	klíšťové encefalitidy	klíšťové encefalitidy
0	brusinkové šťávy	brusinkové šťávy
2	ušního boltce	ušníoh oltce
1	zasílaným informacím	zasílaným niformacím
1	končetinovou ischémií	končetinovou ischmémií
1	příbalovém letáku	příbalovém leátáku