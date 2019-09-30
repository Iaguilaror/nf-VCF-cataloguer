# mk-get-miRNA-variants
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Separate variants with miRNA data.

1. This module filters variants that match with annotations in "miRBase" field.

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

A `VCF` file by each input with the filtered variants with a GeneHancer ID.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	42951004	rs451887	T	C	.	PASS	AC=103;AF_mx=0.686;AN=152;DP=1589;nhomalt_mx=43;ANN=C|mature_miRNA_variant|MODIFIER|MIR5692B|ENSG00000264580|Transcript|ENST00000579137.1|miRNA|1/1||ENST00000579137.1:n.11A>G||11/87|||||rs451887||-1||SNV|HGNC|HGNC:43535|YES||||||||||||||chr21:g.42951004T>C|0.8742|0.9395|0.7839|0.873|0.8678|0.8579|||0.9138|1||1|||0.92|0.5||1|gnomAD_AFR&gnomAD_ASJ|||||||||3.267|0.138611||rs451887|27807|31186|0.89165|589212|91|106|0.858491|40|27996|31402|0.891536|12516|8045|8630|0.932213|3755|1849|2128|0.868891|814|663|844|0.785545|266|1322|1558|0.848524|563|12430|7450|8524|0.874003|3248|4184|4554|0.918753|1921|13574|15312|0.886494|6023|3003|3470|0.865418|1298|239|290|0.824138|96|961|1082|0.88817|429|afr|8045|8630|0.932213|3755|27.83||||||||||||miRNAprimarytranscript_hsa-mir-5692b&miRNAmature_hsa-miR-5692b&miRNAseed_hsa-miR-5692b|||||||
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

## mk-get-miRNA-variants directory structure

````
mk-get-miRNA-variants /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* Kozomara, A., & Griffiths-Jones, S. (2010). miRBase: integrating microRNA annotation and deep-sequencing data. Nucleic acids research, 39(suppl_1), D152-D157.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
