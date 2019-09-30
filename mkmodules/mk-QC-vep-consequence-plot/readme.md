# mk-QC-vep-consequence-plot
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Plot consequences of each category of variants.

## Module Dependencies:
plotter.R 

### Input(s):

A `.tsv` the description of the counted variants by each subgroup of variants.

Example line(s):

```
row_nam	common_freq	commonAMR_lowEUR	low_freq	lowEAS_lowEUR	No_filter	rare_freq	selection_signals
miRNA	0	0	0	0	0	0	0
PGKB	0	0	0	0	0	0	0
GWAScatalog	3	0	0	0	3	0	0
OMIM	6	2	1	0	9	2	0
coding_region	7	0	1	1	19	11	0
clinvar	16	2	2	0	21	3	0
utr	90	5	26	7	161	45	0
dbSNPnovel	35	2	114	3	977	828	0
GeneHancer	599	44	187	47	1033	247	0
dbSNPknown	8995	746	2706	567	14586	2885	0
general (all indels)	9030	748	2820	570	15563	3713	0
```


### Output:

A `.png` with a pie plot of consequences of each category variants. 

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-QC-vep-consequence-plot directory structure

````
mk-QC-vep-consequence-plot /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── plotter.R			    		 ## Script used in this module.
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

