# mk-get-utr-variants
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Separate variants found in 5' or 3' UTR regions.

1. This module filters variants that are in 5' UTR.

2. This module filters variants that are in 3' UTR.

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
chr21	5101724	.	G	A	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=903;nhomalt_mx=0;ANN=A|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19987C>T|||||||||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5101724G>A||||||||||||||||||||||||||||2.079|0.034663||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5102165	rs1373489291	G	T	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=853;nhomalt_mx=0;ANN=T|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19546C>A|||||||rs1373489291||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5102165G>T||||||||||||||||||||||||||||5.009|0.275409||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```


### Output:

A `VCF` file by each input with the filtered variants with a GeneHancer ID.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	6121894	.	T	TTG	.	PASS	AC=6;AF_mx=0.039;AN=150;DP=1168;nhomalt_mx=1;ANN=TG|3_prime_UTR_variant|MODIFIER|SIK1B|ENSG00000275993|Transcript|ENST00000613488.2|protein_coding|14/14||ENST00000613488.2:c.*402_*403dup||2860-2861/4705|||||rs1202887556||1||insertion|HGNC|HGNC:52389|YES|1|P1|CCDS82645.1|ENSP00000482829|A0A0B4J2F2||UPI000000D956||||||28|chr21:g.6121921_6121922dup||||||||||||||||||||||||||||0.494|-0.153000||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	6121894	.	T	TTGTG	.	PASS	AC=1;AF_mx=0.006494;AN=150;DP=1168;nhomalt_mx=0;ANN=TGTG|3_prime_UTR_variant|MODIFIER|SIK1B|ENSG00000275993|Transcript|ENST00000613488.2|protein_coding|14/14||ENST00000613488.2:c.*400_*403dup||2860-2861/4705|||||rs1202887556||1||insertion|HGNC|HGNC:52389|YES|1|P1|CCDS82645.1|ENSP00000482829|A0A0B4J2F2||UPI000000D956||||||28|chr21:g.6121919_6121922dup||||||||||||||||||||||||||||0.472|-0.159271||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
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

## mk-get-utr-variants directory structure

````
mk-get-utr-variants /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.

