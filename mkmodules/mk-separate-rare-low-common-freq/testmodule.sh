#!/bin/bash

## This small script runs a module test with the sample data

## Export variables

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data ; -a arg forces target creation even if results are up to date
## Move results from . to test/results
## files are *.rare_freq.vcf *.low_freq.vcf *.common_freq.vcf
./runmk.sh \
&& mv test/data/*.rare_freq.vcf test/data/*.low_freq.vcf test/data/*.common_freq.vcf test/results \
&& echo "[>>>] Module Test Successful"
