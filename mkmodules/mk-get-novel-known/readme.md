 # mk-get-novel-known
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Separate known and unknown variants.

1. This module filters variants that have an rsID and are reported by dbSNP.
2. This module separate unknown variants (without rsID in dbSNP).

*Outputs will be uncompressed.

## Module Dependencies:
filter_vep >
[Download and compile filter_vep](https://www.ensembl.org/info/docs/tools/vep/script/vep_filter.html)

### Input(s):

 Uncompressed `VCF` file(s) with extension `.vcf`, which mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`.

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5216481	rs1265942733	T	A	.	PASS	AC=72;AF_mx=0.481;AN=150;DP=1398;nhomalt_mx=0;ANN=A|intergenic_variant|MODIFIER|||||||||||||||rs1265942733||||SNV|||||||||||||||||chr21:g.5216481T>A||||||||||||||||||||||||||||8.338|0.617038||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5219334	rs1438890044	AT	A	.	PASS	AC=59;AF_mx=0.396;AN=150;DP=2302;nhomalt_mx=0;ANN=-|intergenic_variant|MODIFIER|||||||||||||||rs1438890044||||deletion|||||||||||||||||chr21:g.5219335del||||||||||||||||||||||||||||3.288|0.152540||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```


### Output:

Two `VCF` file by each input with the filtered variants. One with rsID annotation and another one without it.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5216481	rs1265942733	T	A	.	PASS	AC=72;AF_mx=0.481;AN=150;DP=1398;nhomalt_mx=0;ANN=A|intergenic_variant|MODIFIER|||||||||||||||rs1265942733||||SNV|||||||||||||||||chr21:g.5216481T>A||||||||||||||||||||||||||||8.338|0.617038||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5219334	rs1438890044	AT	A	.	PASS	AC=59;AF_mx=0.396;AN=150;DP=2302;nhomalt_mx=0;ANN=-|intergenic_variant|MODIFIER|||||||||||||||rs1438890044||||deletion|||||||||||||||||chr21:g.5219335del||||||||||||||||||||||||||||3.288|0.152540||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5227412	.	TTCCCTTC	T	.	PASS	AC=9;AF_mx=0.058;AN=152;DP=2486;nhomalt_mx=1;ANN=-|intergenic_variant|MODIFIER|||||||||||||||||||deletion|||||||||||||||||chr21:g.5227413_5227419del|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5227531	.	C	CTTTCCTCTCCTCTCT	.	PASS	AC=8;AF_mx=0.051;AN=152;DP=1637;nhomalt_mx=2;ANN=TTTCCTCTCCTCTCT|intergenic_variant|MODIFIER|||||||||||||||||||insertion|||||||||||||||||chr21:g.5227537_5227538insCTCCTCTCTTTTCCT|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

```

**Note(s):**
* Ouput and input will have the same structure, the only change to files is that the variants will be set according each filter.


## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-get-novel-known directory structure

````
mk-get-novel-known /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* Kitts, A., & Sherry, S. (2002). The single nucleotide polymorphism database (dbSNP) of nucleotide sequence variation. The NCBI Handbook. McEntyre J, Ostell J, eds. Bethesda, MD: US National Center for Biotechnology Information.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
