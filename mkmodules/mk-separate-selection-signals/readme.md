# mk-separate-selection-signals
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Keep only variants with a selection signals.

1. This module only includes variants that have an rsID in common with a `.txt` file that contains the results for a selection signal analysis.

2. This module sorts the final output.

*Output will be uncompressed.

## Module Dependencies:
bcftools 1.9-220-gc65ba41 >
[Download and compile bcftools](https://samtools.github.io/bcftools/)

### Inputs:

#### Input 1

A `VCF` file with a `.vcf` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. ID must provide an rsID in ID column.

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5101724	.	G	A	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=903;nhomalt_mx=0;ANN=A|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19987C>T|||||||||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5101724G>A||||||||||||||||||||||||||||2.079|0.034663||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5219403	rs71221935	G	T	.	PASS	AC=150;AF_mx=0.987;AN=152;DP=2490;nhomalt_mx=74;ANN=T|intergenic_variant|MODIFIER|||||||||||||||rs71221935||||SNV|||||||||||||||||chr21:g.5219403G>T||||||||||||||||||||||||||||9.129|0.712287||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```
#### Input 2

List of rsIDs, result of selection analysis, with extension `.txt`

### Output:

An uncompressed `VCF` file, with selection signals which contains annotation fields an information.

Example line(s):  
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	7919337	rs993746776	A	G	.	PASS	AC=121;AF_mx=0.801;AN=152;DP=5447;nhomalt_mx=45;ANN=G|intergenic_variant|MODIFIER|||||||||||||||rs993746776||||SNV|||||||||||||||||chr21:g.7919337A>G||||||||||||||||||||||||||||10.98|0.902882||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	9760908	rs76218657	C	T	.	PASS	AC=44;AF_mx=0.288;AN=152;DP=4923;nhomalt_mx=0;ANN=T|intergenic_variant|MODIFIER|||||||||||||||rs76218657||||SNV|||||||||||||||||chr21:g.9760908C>T||||||||||||||||||||||||||||4.609|0.242732||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```

## Module parameters:
Path to reference ID file `.txt`
```
RSID_LIST="test/reference/91G_rsIDs_selection_signals_by_ihs.txt"
```

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-separate-selection-signals structure

````
mk-separate-selection-signals/				## Module main directory
├── mkfile								## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
