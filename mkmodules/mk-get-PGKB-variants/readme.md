# mk-get-PGKB-variants
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Separate variants found in PGKB database.

1. This module filters variants that match with annotations in "PGKB" field.

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
chr21	13425916	rs466850	G	C	.	PASS	AC=86;AF_mx=0.571;AN=152;DP=1474;nhomalt_mx=29;ANN=C|intron_variant&non_coding_transcript_variant|MODIFIER|ANKRD30BP1|ENSG00000175302|Transcript|ENST00000451052.1|unprocessed_pseudogene||4/17|ENST00000451052.1:n.204+230C>G|||||||rs466850||-1||SNV|HGNC|HGNC:19722|YES||||||||||||||chr21:g.13425916G>C|0.2750|0.0651|0.4841|0.3452|0.3459|0.2648||||||||||||0.4841|AMR|||1||||||1.441|-0.036760||rs466850|7830|31324|0.249968|641245|37|104|0.355769|7|7868|31416|0.250446|1179|740|8704|0.0850184|26|733|2132|0.343809|120|387|848|0.456368|85|544|1550|0.350968|90|1165|2940|8578|0.342737|499|1151|4566|0.252081|163|4861|15380|0.31606|789|850|3468|0.245098|103|123|290|0.424138|20|325|1084|0.299815|52|amr|387|848|0.456368|85|31.31|rs466850|Lower_body_strength|822_European_ancestry_individuals|NA|rs466850-C|3e-06|GCST004493||||||||||||
chr21	13901423	rs56254584	C	G	.	PASS	AC=13;AF_mx=0.09;AN=152;DP=1540;nhomalt_mx=1;ANN=G|downstream_gene_variant|MODIFIER|SNX18P13|ENSG00000230965|Transcript|ENST00000412442.1|processed_pseudogene||||||||||rs56254584|4537|-1||SNV|HGNC|HGNC:39621|YES||||||||||||||chr21:g.13901423C>G|0.3179|0.1649|0.2723|0.369|0.3767|0.4438||||||||||||0.4438|SAS|||1||||||0.816|-0.134607||rs56254584|10097|31124|0.324412|590589|40|104|0.384615|9|10196|31416|0.324548|1745|1837|8608|0.213406|203|811|2122|0.382187|162|204|846|0.241135|25|544|1536|0.354167|95|1714|3208|8524|0.376349|590|1624|4546|0.357237|291|5683|15296|0.371535|1052|1347|3470|0.388184|249|98|288|0.340278|18|384|1080|0.355556|72|nfe|5683|15296|0.371535|1052|27.41|rs56254584|Interleukin-2_levels|475_Finnish_ancestry_individuals|NA|rs56254584-G|5e-06|GCST004455||||||||||||
```


### Output:

A `VCF` file by each input with the filtered variants with a GeneHancer ID.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	28055779	rs2831440	G	T	.	PASS	AC=74;AF_mx=0.494;AN=152;DP=1471;nhomalt_mx=17;ANN=T|intron_variant&non_coding_transcript_variant|MODIFIER|LINC01697|ENSG00000232079|Transcript|ENST00000426534.2|lincRNA||1/4|ENST00000426534.2:n.134+7242G>T|||||||rs2831440||1||SNV|HGNC|HGNC:52485|YES|2|||||||||||||chr21:g.28055779G>T|0.3203|0.1543|0.3991|0.4177|0.332|0.3763||||||||||||0.4177|EAS||||27091189|||||0.322|-0.272827||rs2831440|9799|31340|0.312668|665738|38|104|0.365385|6|9818|31416|0.312516|1634|1765|8694|0.203014|182|710|2136|0.332397|122|328|844|0.388626|51|636|1556|0.40874|145|1628|2885|8576|0.336404|494|1759|4584|0.383726|340|5392|15400|0.35013|962|1198|3474|0.344847|208|109|288|0.378472|16|371|1084|0.342251|64|eas|636|1556|0.40874|145|32.05|||||||||||||rs2831440|1447983254||antidepressants_(PA452229)|27091189|efficacy|_Major_as_compared_to_allele_G.
chr21	28883961	rs2254638	A	G	.	PASS	AC=78;AF_mx=0.513;AN=152;DP=1781;nhomalt_mx=22;ANN=G|intron_variant|MODIFIER|N6AMT1|ENSG00000156239|Transcript|ENST00000303775.10|protein_coding||1/5|ENST00000303775.10:c.135-890T>C|||||||rs2254638||-1||SNV|HGNC|HGNC:16021|YES|1|P4|CCDS33526.1|ENSP00000303584|Q9Y5N5||UPI000003B020|||||||chr21:g.28883961A>G||0.6868|0.7378|0.5317|0.8787|0.9305||||||||||||0.9305|SAS||||27981573&30283338|||||9.105|0.709479|GH21J028883_Promoter/Enhancer_N6AMT1|rs2254638|25450|31358|0.811595|672355|94|106|0.886792|42|25496|31416|0.811561|10549|6096|8688|0.701657|2144|1854|2134|0.868791|810|595|846|0.70331|216|804|1554|0.517375|208|10529|7533|8594|0.876542|3298|4092|4582|0.89306|1829|13573|15416|0.880449|5979|3175|3476|0.913406|1453|261|290|0.9|117|946|1088|0.869485|412|nfe|13573|15416|0.880449|5979|31.66|||||||||||||rs2254638&rs2254638|1448624859&1450117776|N6AMT1_(PA162396656)&N6AMT1_(PA162396656)|clopidogrel_(PA449053)&clopidogrel_(PA449053)|27981573&30487649|metabolism/PK&efficacy|Allele_G_is_associated_with_decreased_metabolism_of_clopidogrel_as_compared_to_genotype_AA.&Allele_G_is_associated_with_decreased_response_to_clopidogrel_in_people_with_Coronary_Artery_Disease_as_compared_to_allele_A.
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

## mk-get-PGKB-variants directory structure

````
mk-get-PGKB-variants /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
* Whirl‐Carrillo, M., McDonagh, E. M., Hebert, J. M., Gong, L., Sangkuhl, K., Thorn, C. F., ... & Klein, T. E. (2012). Pharmacogenomics knowledge for personalized medicine. Clinical Pharmacology & Therapeutics, 92(4), 414-417.
