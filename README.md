Testing Aspell for Czech Mispellings
====================================

# Author #
Nolan Lawson

# License #
GPL 2.0

# Usage #

This will run on any Unix-like system with Aspell and the Czech Aspell dictionaries installed.

To run all the tests, use `./run_tests.sh`.  This will create a `/tmp/results.txt` file which contains verbose output.  To summarize the output, run `./summarize_results.pl`.

# Test Set #

From Pavel:

```
1) We POS-tagged our BMC collection of medical documents in Czech and
extracted "interesting" expressions (noun phrases, consisting of 1-3
words) based on their frequency and pointwise mutual information. So all
the expressions are likely to be used as queries in Khresmoi.

2) We have introduced three types of errors letter errors (insertion,
deletion, swap, replacement, each appearing in 20% of erroneous words),
diacritics strip (50% of erroneous words), concatenation of words (10%
of erroneous words).
```

# Results #

Based on the included misspelled Czech term data, Aspell v0.60.6 generates the following results: 

```
Filename                            Correct  Incorrect  Accuracy
data/spellchecking-data-1-10.txt	526	027	0.9511754069
data/spellchecking-data-1-20.txt	496	057	0.896925859
data/spellchecking-data-1-30.txt	497	056	0.8987341772
data/spellchecking-data-1-40.txt	479	074	0.8661844485
data/spellchecking-data-1-50.txt	456	097	0.8245931284
data/spellchecking-data-2-10.txt	270	076	0.7803468208
data/spellchecking-data-2-20.txt	239	107	0.6907514451
data/spellchecking-data-2-30.txt	211	135	0.6098265896
data/spellchecking-data-2-40.txt	178	168	0.5144508671
data/spellchecking-data-2-50.txt	168	178	0.4855491329
data/spellchecking-data-3-10.txt	575	184	0.7575757576
data/spellchecking-data-3-20.txt	472	287	0.6218708827
data/spellchecking-data-3-30.txt	436	323	0.5744400527
data/spellchecking-data-3-40.txt	423	336	0.557312253
data/spellchecking-data-3-50.txt	342	417	0.4505928854
```
