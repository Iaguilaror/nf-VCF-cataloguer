# mk-separate-lowEAS-lowEUR
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Separate variants by its allele frequency comparing other populations of gnomAD database.

1. This module filters variants with more than 5% of allele frequency in local population.

2. This module filters variants with less than 5% of allele frequency in EAS and NFE gnomAD population.

*Outputs will be uncompressed.

## Module Dependencies:
filter_vep >
[Download and compile filter_vep](https://www.ensembl.org/info/docs/tools/vep/script/vep_filter.html)

### Input:

 A `VCF` file which mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`.

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5101724	.	G	A	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=903;nhomalt_mx=0;ANN=A|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19987C>T|||||||||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5101724G>A||||||||||||||||||||||||||||2.079|0.034663||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5102165	rs1373489291	G	T	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=853;nhomalt_mx=0;ANN=T|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19546C>A|||||||rs1373489291||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5102165G>T||||||||||||||||||||||||||||5.009|0.275409||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```
Observe that this variants do not have AF_mx > 5%

### Output:

A `VCF` file with the filtered variants.

Example line(s):  

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	8704960	rs564462561	C	T	.	PASS	AC=24;AF_mx=0.154;AN=152;DP=2777;nhomalt_mx=3;ANN=T|downstream_gene_variant|MODIFIER|CR381572.1|ENSG00000279167|Transcript|ENST00000625098.1|processed_pseudogene||||||||||rs564462561|3398|1||SNV|Clone_based_ensembl_gene||YES||||||||||||||chr21:g.8704960C>T|0.0090|0.0008|0.0634|0|0|0||||||||||||0.0634|AMR|||||||||6.070|0.369895||rs564462561|22|31340|0.000701978|1894375|0|106|0|0|58|31416|0.00184619|0|0|8706|0|0|0|2136|0|0|19|800|0.02375|0|0|1560|0|0|0|0|8596|0|0|2|4588|0.00043592|0|2|15426|0.000129651|0|0|3476|0|0|0|290|0|0|1|1082|0.000924214|0|amr|19|800|0.02375|0|82.63|||||||||||||||||||
chr21	8788219	rs1332277113	ATTT	A	.	PASS	AC=9;AF_mx=0.071;AN=152;DP=2445;nhomalt_mx=0;ANN=-|intron_variant&non_coding_transcript_variant|MODIFIER|CR381670.2|ENSG00000286033|Transcript|ENST00000651312.1|lincRNA||2/2|ENST00000651312.1:n.199+18791_199+18793del|||||||rs1332277113||-1||deletion|Clone_based_ensembl_gene||YES||||||||||||||chr21:g.8788224_8788226del||||||||||||||||||||||||||||4.055|0.202643||rs1358720830|7|31124|0.000224907|1717522|0|106|0|0|38|31416|0.00120957|0|1|8480|0.000117925|0|0|2136|0|0|6|804|0.00746269|0|0|1558|0|0|0|0|8596|0|0|0|4594|0|0|0|15432|0|0|0|3476|0|0|0|290|0|0|0|1084|0|0|amr|6|804|0.00746269|0|80.15&80.18&80.18|||||||||||||||||||

```

Observe that the output has an AF_mx value > 5%.

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-separate-lowEAS-lowEUR directory structure

````
mk-separate-lowEAS-lowEUR/								## Module main directory
├── mkfile								## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* Karczewski, K. J., Francioli, L. C., Tiao, G., Cummings, B. B., Alföldi, J., Wang, Q., ... & Gauthier, L. D. (2019). Variation across 141,456 human exomes and genomes reveals the spectrum of loss-of-function intolerance across human protein-coding genes. BioRxiv, 531210.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
