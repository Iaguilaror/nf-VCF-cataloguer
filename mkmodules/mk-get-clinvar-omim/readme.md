# mk-get-clinvar-omim
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Separate variants annotated by ClinVar database.

1. This module filters variants that match with annotations in ClinVar field.

2. This module filters variants with OMIM data.

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
cchr21	5216481	rs1265942733	T	A	.	PASS	AC=72;AF_mx=0.481;AN=150;DP=1398;nhomalt_mx=0;ANN=A|intergenic_variant|MODIFIER|||||||||||||||rs1265942733||||SNV|||||||||||||||||chr21:g.5216481T>A||||||||||||||||||||||||||||8.338|0.617038||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	25880756	rs736479	C	T	.	PASS	AC=11;AF_mx=0.071;AN=152;DP=1197;nhomalt_mx=1;ANN=T|3_prime_UTR_variant|MODIFIER|APP|ENSG00000142192|Transcript|ENST00000346798.8|protein_coding|18/18||ENST00000346798.8:c.*914G>A||3377/3583|||||rs736479||-1||SNV|HGNC|HGNC:620|YES|1|P4|CCDS13576.1|ENSP00000284981|P05067|A0A140VJC8|UPI000002DB1C||1|||||chr21:g.25880756C>T|0.0054|0|0.0375|0|0.001|0||||||||||||0.0375|AMR|likely_benign||1|21982160|||||0.049|-0.509403||rs736479|50|31394|0.00159266|632478|0|106|0|0|50|31416|0.00159155|1|6|8710|0.000688863|0|0|2138|0|0|43|848|0.0507075|1|0|1556|0|0|1|0|8596|0|0|0|4590|0|0|0|15430|0|0|0|3474|0|0|0|290|0|0|1|1086|0.00092081|0|amr|43|848|0.0507075|1|31.62||||||||chr21:25880756-25880756|Early-Onset_Familial_Alzheimer_Disease|Likely_benign|MedGen:CN043596||||||||
```


### Output:

Two `VCF` files by each input with the filtered variants, one per OMIM and one per ClinVar.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	25880756	rs736479	C	T	.	PASS	AC=11;AF_mx=0.071;AN=152;DP=1197;nhomalt_mx=1;ANN=T|3_prime_UTR_variant|MODIFIER|APP|ENSG00000142192|Transcript|ENST00000346798.8|protein_coding|18/18||ENST00000346798.8:c.*914G>A||3377/3583|||||rs736479||-1||SNV|HGNC|HGNC:620|YES|1|P4|CCDS13576.1|ENSP00000284981|P05067|A0A140VJC8|UPI000002DB1C||1|||||chr21:g.25880756C>T|0.0054|0|0.0375|0|0.001|0||||||||||||0.0375|AMR|likely_benign||1|21982160|||||0.049|-0.509403||rs736479|50|31394|0.00159266|632478|0|106|0|0|50|31416|0.00159155|1|6|8710|0.000688863|0|0|2138|0|0|43|848|0.0507075|1|0|1556|0|0|1|0|8596|0|0|0|4590|0|0|0|15430|0|0|0|3474|0|0|0|290|0|0|1|1086|0.00092081|0|amr|43|848|0.0507075|1|31.62||||||||chr21:25880756-25880756|Early-Onset_Familial_Alzheimer_Disease|Likely_benign|MedGen:CN043596||||||||

```
**Note(s):**
* ClinVar and OMIM files might share variants.
* Ouput and input will have the same structure, the only change to files is that the variants will be set according each filter.


## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-get-clinvar-omim  directory structure

````
mk-get-clinvar-omim /				    	## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* Landrum, M. J., & Kattman, B. L. (2018). Clinvar at five years: delivering on the promise. Human mutation, 39(11), 1623-1630.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
