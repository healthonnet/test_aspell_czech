for file in `ls data/*`; do echo $file>> /tmp/results.txt; perl test_aspell.pl $file >>/tmp/results.txt 2>>/tmp/error.txt; echo >>/tmp/results.txt; done
