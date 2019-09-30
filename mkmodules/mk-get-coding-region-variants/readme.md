 # mk-get-coding-region-variants
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Separate variants in coding regions.

1. This module separates exonic variants.
2. Filters intronic variants.

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

A `VCF` file with the filtered variants.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	10542440	rs468525	G	A	.	PASS	AC=3;AF_mx=0.019;AN=152;DP=2848;nhomalt_mx=0;ANN=A|synonymous_variant|LOW|TPTE|ENSG00000274391|Transcript|ENST00000618007.4|protein_coding|6/24||ENST00000618007.4:c.111G>A|ENSP00000484403.1:p.Ala37%3D|441/2150|111/1656|37/551|A|gcG/gcA|rs468525||1||SNV|HGNC|HGNC:12023|YES|1|P4|CCDS74771.1|ENSP00000484403|P56180||UPI000016A18A|||||MobiDB_lite:mobidb-lite||chr21:g.10542440G>A||0.4629|0.1311|0.256|0.1183|0.1933|||0.09062|0.4315|0.04437|0.1068|0.1748|0.03759|0.05835|0.07906|0.1049|0.4629|AFR|||||||||3.680|0.170641||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	10567782	rs769232775	A	G	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=2463;nhomalt_mx=0;ANN=G|missense_variant|MODERATE|TPTE|ENSG00000274391|Transcript|ENST00000618007.4|protein_coding|11/24||ENST00000618007.4:c.559A>G|ENSP00000484403.1:p.Ile187Val|889/2150|559/1656|187/551|I/V|Att/Gtt|rs769232775||1||SNV|HGNC|HGNC:12023|YES|1|P4|CCDS74771.1|ENSP00000484403|P56180||UPI000016A18A|||tolerated|benign|Gene3D:1.20.120.350&Superfamily_domains:SSF81324||chr21:g.10567782A>G|||||||||3.987e-05|0|0.0002609|0|0|0|8.824e-06|0|0|0.0002609|gnomAD_AMR|||||||||12.75|1.057621||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
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

## mk-get-coding-region-variants directory structure

````
mk-get-coding-region-variants /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
