# mk-separate-snv-indel
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Keep only certain types of variants.

1. This module only includes snp variants of a compressed VCF file `.vcf.gz`.

2. This module only includes indel variants of a compressed VCF file `.vcf.gz`.

*Outputs will be uncompressed.

## Module Dependencies:
bcftools 1.9-220-gc65ba41 >
[Download and compile bcftools](https://samtools.github.io/bcftools/)

### Input:

A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. 

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5102165	rs1373489291	G	T	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=853;nhomalt_mx=0;ANN=T|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19546C>A|||||||rs1373489291||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5102165G>T||||||||||||||||||||||||||||5.009|0.275409||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5219334	rs1438890044	AT	A	.	PASS	AC=59;AF_mx=0.396;AN=150;DP=2302;nhomalt_mx=0;ANN=-|intergenic_variant|MODIFIER|||||||||||||||rs1438890044||||deletion|||||||||||||||||chr21:g.5219335del||||||||||||||||||||||||||||3.288|0.152540||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```
Observe that in the input file exists different types of variants.

### Output:

Two uncompressed `VCF` files, one for snps and other for indels.

Example line(s):  
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5102165	rs1373489291	G	T	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=853;nhomalt_mx=0;ANN=T|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19546C>A|||||||rs1373489291||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5102165G>T||||||||||||||||||||||||||||5.009|0.275409||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5216481	rs1265942733	T	A	.	PASS	AC=72;AF_mx=0.481;AN=150;DP=1398;nhomalt_mx=0;ANN=A|intergenic_variant|MODIFIER|||||||||||||||rs1265942733||||SNV|||||||||||||||||chr21:g.5216481T>A||||||||||||||||||||||||||||8.338|0.617038||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5219334	rs1438890044	AT	A	.	PASS	AC=59;AF_mx=0.396;AN=150;DP=2302;nhomalt_mx=0;ANN=-|intergenic_variant|MODIFIER|||||||||||||||rs1438890044||||deletion|||||||||||||||||chr21:g.5219335del||||||||||||||||||||||||||||3.288|0.152540||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5227412	rs1182294281	TTC	T	.	PASS	AC=10;AF_mx=0.071;AN=152;DP=2486;nhomalt_mx=0;ANN=-|intergenic_variant|MODIFIER|||||||||||||||rs1182294281||||deletion|||||||||||||||||chr21:g.5227413_5227414del|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```

Note that the variant with AN<150 has been removed.

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-separate-snv-indel directory structure

````
mk-separate-snv-indel/								## Module main directory
├── mkfile								## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.