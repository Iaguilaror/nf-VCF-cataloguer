nf-vcf-cataloguer
===
'nf-vcf-cataloguer' is a tool, implemented in Nextflow, that generates a general table description in tsv format of the description of each category and subgroup of a vcf with the extended annotation made by VEP. Furthermore it plots each subset consequences of variants.

---

### Features
  **-v 0.0.1**

* nf-vcf-cataloguer supports vcf compressed files as input.
* Results include a general table description in tsv and images of each subgroup consequences.
* Scalability and reproducibility via a Nextflow-based framework.
* nf-vcf-cataloguer obtains GeneHancer variants annotation converted to tsv format.
* nf-vcf-cataloguer separates rare, low and common variants annotation converted to tsv format using the gnomAD fields from nf-vcf-cataloguer.
* nf-vcf-cataloguer separates GWAS Catalog variants annotation converted to tsv format.
* nf-vcf-cataloguer separates ClinVar and OMIM variants annotation converted to tsv format.
* nf-vcf-cataloguer separates miRBase variants annotation converted to tsv format.
* nf-vcf-cataloguer separates PGKB Drug variants annotation converted to tsv format.
* nf-vcf-cataloguer separates dbsnp known and novel ones.
* nf-vcf-cataloguer separates coding region variants and utr region variants.
* nf-vcf-cataloguer separates indels and snvs.
* nf-vcf-cataloguer separates selection signals with rsIDs list obtained from a selection analysis.

---

## Requirements
#### Compatible OS*:
* [Ubuntu 18.04.03 LTS](http://releases.ubuntu.com/18.04/)

\* nf-vcf-cataloguer may run in other UNIX based OS and versions, but testing is required.

#### Software:
| Requirement | Version  | Required Commands * |
|:---------:|:--------:|:-------------------:|
| [bcftools](https://samtools.github.io/bcftools/) | 1.9-220-gc65ba41 | bcftools |
| [htslib](http://www.htslib.org/download/) | 1.9 | tabix, bgzip |
| [filter_vep](http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html) | 96 & 97 | vep |
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 19.04.1.5072 | nextflow |
| [Plan9 port](https://github.com/9fans/plan9port) | Latest (as of 10/01/2019 ) | mk \** |
| [R](https://www.r-project.org/) | 3.4.4 | ** See R scripts |

\* These commands must be accessible from your `$PATH` (*i.e.* you should be able to invoke them from your command line).  

\** Plan9 port builds many binaries, but you ONLY need the `mk` utility to be accessible from your command line.

---

### Installation
Download nf-vcf-cataloguer from Github repository:  
```
git clone https://github.com/Iaguilaror/nf-vcf-cataloguer.git
```

---

#### Test
To test nf-vcf-cataloguer's execution using test data, run:
```
./runtest.sh
```

Your console should print the Nextflow log for the run, once every process has been submitted, the following message will appear:
```
======
Basic pipeline TEST SUCCESSFUL: Basic pipeline TEST SUCCESSFUL
======
```

nf-vcf-cataloguer results for test data should be in the following file:
```
nf-vcf-cataloguer/test/results/catgorizeVCF-results
```

---

### Usage
To run nf-vcf-cataloguer go to the pipeline directory and execute:
```
nextflow run categorize-vcf.nf --vcf <path to input 1> [--output_dir path to results] [-resume]
```

For information about options and parameters, run:
```
nextflow run categorize-vcf.nf --help
```

---

### Pipeline Inputs
* A compressed vcf file with extension '.vcf.gz', which must have a TABIX index with .tbi extension, located in the same directory as the vcf file.

 The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. INFO must contain "AN", which is the target for filtering of this module.

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	5101724	.	G	A	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=903;nhomalt_mx=0;ANN=A|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19987C>T|||||||||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5101724G>A||||||||||||||||||||||||||||2.079|0.034663||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5102165	rs1373489291	G	T	.	PASS	AC=1;AF_mx=0.00641;AN=140;DP=853;nhomalt_mx=0;ANN=T|intron_variant|MODIFIER|GATD3B|ENSG00000280071|Transcript|ENST00000624810.3|protein_coding||4/5|ENST00000624810.3:c.357+19546C>A|||||||rs1373489291||-1|cds_start_NF&cds_end_NF|SNV|HGNC|HGNC:53816||5|||ENSP00000485439||A0A096LP73|UPI0004F23660|||||||chr21:g.5102165G>T||||||||||||||||||||||||||||5.009|0.275409||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```

* `*.txt` : A selection signals file which lists rsIDs. 
* `fields_to extract.txt` : A reference file to extract certain fields of vcf and transform it to tsv format.

---

### Pipeline Results
* Compressed tsv files with `filtered.*.tsv.gz` extension. 

Example line(s):
```
CHROM	POS	ID	REF	ALT	AC	AN	DP	AF_mx	nhomalt_mx	Allele	Consequence	IMPACT	SYMBOL	Gene	Feature_type	Feature	BIOTYPE	EXON	INTRON	HGVSc	HGVSp	cDNA_position	CDS_position	Protein_position	Amino_acids	Codons	Existing_variation	DISTANCE	STRAND	FLAGS	VARIANT_CLASS	SYMBOL_SOURCE	HGNC_ID	CANONICAL	TSL	APPRIS	CCDS	ENSP	SWISSPROT	TREMBL	UNIPARC	SOURCE	GENE_PHENO	SIFT	PolyPhen	DOMAINS	HGVS_OFFSET	HGVSg	AF	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	AA_AF	EA_AF	gnomAD_AF	gnomAD_AFR_AF	gnomAD_AMR_AF	gnomAD_ASJ_AF	gnomAD_EAS_AF	gnomAD_FIN_AF	gnomAD_NFE_AF	gnomAD_OTH_AF	gnomAD_SAS_AF	MAX_AF	MAX_AF_POPS	CLIN_SIG	SOMATIC	PHENO	PUBMED	MOTIF_NAME	MOTIF_POS	HIGH_INF_POS	MOTIF_SCORE_CHANGE	CADD_PHRED	CADD_RAW	GeneHancer_type_and_Genes	gnomADg	gnomADg_AC	gnomADg_AN	gnomADg_AF	gnomADg_DP	gnomADg_AC_nfe_seu	gnomADg_AN_nfe_seu	gnomADg_AF_nfe_seu	gnomADg_nhomalt_nfe_seu	gnomADg_AC_raw	gnomADg_AN_raw	gnomADg_AF_raw	gnomADg_nhomalt_raw	gnomADg_AC_afr	gnomADg_AN_afr	gnomADg_AF_afr	gnomADg_nhomalt_afr	gnomADg_AC_nfe_onf	gnomADg_AN_nfe_onf	gnomADg_AF_nfe_onf	gnomADg_nhomalt_nfe_onf	gnomADg_AC_amr	gnomADg_AN_amr	gnomADg_AF_amr	gnomADg_nhomalt_amr	gnomADg_AC_eas	gnomADg_AN_eas	gnomADg_AF_eas	gnomADg_nhomalt_eas	gnomADg_nhomalt	gnomADg_AC_nfe_nwe	gnomADg_AN_nfe_nwe	gnomADg_AF_nfe_nwe	gnomADg_nhomalt_nfe_nwe	gnomADg_AC_nfe_est	gnomADg_AN_nfe_est	gnomADg_AF_nfe_est	gnomADg_nhomalt_nfe_est	gnomADg_AC_nfe	gnomADg_AN_nfe	gnomADg_AF_nfe	gnomADg_nhomalt_nfe	gnomADg_AC_fin	gnomADg_AN_fin	gnomADg_AF_fin	gnomADg_nhomalt_fin	gnomADg_AC_asj	gnomADg_AN_asj	gnomADg_AF_asj	gnomADg_nhomalt_asj	gnomADg_AC_oth	gnomADg_AN_oth	gnomADg_AF_oth	gnomADg_nhomalt_oth	gnomADg_popmax	gnomADg_AC_popmax	gnomADg_AN_popmax	gnomADg_AF_popmax	gnomADg_nhomalt_popmax	gnomADg_cov	gwascatalog	gwascatalog_GWAScat_DISEASE_or_TRAIT	gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE	gwascatalog_GWAScat_REPLICATION_SAMPLE_SIZE	gwascatalog_GWAScat_STRONGEST_SNP_and_RISK_ALLELE	gwascatalog_GWAScat_PVALUE	gwascatalog_GWAScat_STUDY_ACCESSION	clinvar	clinvar_CLNDN	clinvar_CLNSIG	clinvar_CLNDISDB	miRBase	pharmgkb_drug	pharmgkb_drug_PGKB_Annotation_ID	pharmgkb_drug_PGKB_Gene	pharmgkb_drug_PGKB_Chemical	pharmgkb_drug_PGKB_PMID	pharmgkb_drug_PGKB_Phenotype_Category	pharmgkb_drug_PGKB_Sentence
chr21	10521658	rs13050694	G	C	75	152	2931	0.494	0	C	5_prime_UTR_variant	MODIFIER	TPTE	ENSG00000274391	Transcript	ENST00000618007.4	protein_coding	1/24	.	ENST00000618007.4:c.-247G>C	.	84/2150	.	.	.	.	rs13050694	.	1	.	SNV	HGNC	HGNC:12023	YES	1	P4	CCDS74771.1	ENSP00000484403	P56180	.	UPI000016A18A	.	.	.	.	.	.	chr21:g.10521658G>C	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	10.91	0.897134	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	45.51	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.
```
 
* Compressed tsv files with `.indel-variants_summary.tsv` or `snv-variants_summary.tsv` extension.

Example line(s):
```
row_nam common_freq     commonAMR_lowEUR        low_freq        lowEAS_lowEUR   No_filter       rare_freq       selection_signals
miRNA   1       0       0       0       1       0       0
PGKB    8       0       0       0       8       0       0
OMIM    52      6       26      3       104     26      0
GWAScatalog     189     2       12      1       216     15      0
clinvar 169     18      35      11      259     55      0
coding_region   323     29      75      30      648     250     0
utr     525     41      139     37      1004    340     0
GeneHancer      4520    325     787     259     7522    2215    0
dbSNPnovel      0       0       400     0       8033    7633    0
dbSNPknown      66165   5304    13095   3741    101976  22716   5
general (all snv)       66165   5304    13495   3741    110009  30349   5
```
* Plots of the consequences of each subgroup of variants.

#### Output format Descriptions:
TSV outputs have columns that were added in VEPextended. For mor info about fields description, see: https://www.ensembl.org/info/docs/tools/vep/vep_formats.html#other_fields 

---

### nf-vcf-cataloguer directory structure
````
nf-vcf-cataloguer/						## Pipeline main directory.
├── categorize-vcf.nf				## Flow control script of this pipeline.
├── launchers			     		## Directory for different scripts to run categorize-vcf.nf
│   ├── 78G_at_castillo.sh
│   └── 78G_at_luna.sh
├── mkmodules					## Directory for submodule organization
│   ├── mk-count-variants			## Submodule to count variants of each subgroup.
│   ├── mk-custom-filter			## Submodule to filter according AN.
│   ├── mk-get-clinvar-omim			## Submodule to separate variants in ClinVar.
│   ├── mk-get-coding-region-variants			## Submodule to separate variants in coding regions.
│   ├── mk-get-GeneHancer-variants			## Submodule to separate variants in GeneHancer regions.
│   ├── mk-get-GWAScatalog-variants			## Submodule to separate GWAS catalog variants.
│   ├── mk-get-miRNA-variants			## Submodule to separate variants of miRNAs.
│   ├── mk-get-novel-known			## Submodule to separate novel and known variants.
│   ├── mk-get-PGKB-variants			## Submodule to separate variants in PGKB database.
│   ├── mk-get-utr-variants			## Submodule to separate variants in UTR regions.
│   ├── mk-QC-vep-consequence-plot			## Submodule to plot consequence of variants.
│   ├── mk-separate-commonAMR-lowEUR			## Submodule to separate variants according its AF.
│   ├── mk-separate-lowEAS-lowEUR			## Submodule to separate variants according its AF.
│   ├── mk-separate-rare-low-common-freq			## Submodule to separate variants according its AF.
│   ├── mk-separate-selection-signals			## Submodule to separate selection signals.
│   ├── mk-separate-snv-indel			## Submodule to separate variants in snvs and indels.
│   ├── mk-vcf2tsv			## Submodule to convert vcf files to tsv format.
│   └── test
├── nextflow.config				## Configuration file for this pipeline.
├── README.MD					## This document. General workflow description
├── runtest.sh					## Execution script for pipeline testing.
└── test							## Test directory.
    ├── data						## Test data directory
    └── reference							## Test references directory.

````

#### References
Under the hood nf-vcf-cataloguer separates variants from different dabatases and uses some coding tools, please include the following ciations in your work:

* Fishilevich, S., Nudel, R., Rappaport, N., Hadar, R., Plaschkes, I., Iny Stein, T., ... & Lancet, D. (2017). GeneHancer: genome-wide integration of enhancers and target genes in GeneCards. Database, 2017.
* Karczewski, K. J., Francioli, L. C., Tiao, G., Cummings, B. B., Alföldi, J., Wang, Q., ... & Gauthier, L. D. (2019). Variation across 141,456 human exomes and genomes reveals the spectrum of loss-of-function intolerance across human protein-coding genes. BioRxiv, 531210.
* Kitts, A., & Sherry, S. (2002). The single nucleotide polymorphism database (dbSNP) of nucleotide sequence variation. The NCBI Handbook. McEntyre J, Ostell J, eds. Bethesda, MD: US National Center for Biotechnology Information.
* Kozomara, A., & Griffiths-Jones, S. (2010). miRBase: integrating microRNA annotation and deep-sequencing data. Nucleic acids research, 39(suppl_1), D152-D157.
* Landrum, M. J., & Kattman, B. L. (2018). Clinvar at five years: delivering on the promise. Human mutation, 39(11), 1623-1630.
* Li, H. (2011). Tabix: fast retrieval of sequence features from generic TAB-delimited files. Bioinformatics, 27(5), 718-719.
* MacArthur, J., Bowler, E., Cerezo, M., Gil, L., Hall, P., Hastings, E., ... & Pendlington, Z. M. (2016). The new NHGRI-EBI Catalog of published genome-wide association studies (GWAS Catalog). Nucleic acids research, 45(D1), D896-D901.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
* Rentzsch, P., Witten, D., Cooper, G. M., Shendure, J., & Kircher, M. (2018). CADD: predicting the deleteriousness of variants throughout the human genome. Nucleic acids research, 47(D1), D886-D894.
* Team, R. C. (2017). R: a language and environment for statistical computing. R Foundation for Statistical Computing, Vienna. http s. www. R-proje ct. org.
* Whirl‐Carrillo, M., McDonagh, E. M., Hebert, J. M., Gong, L., Sangkuhl, K., Thorn, C. F., ... & Klein, T. E. (2012). Pharmacogenomics knowledge for personalized medicine. Clinical Pharmacology & Therapeutics, 92(4), 414-417.


---

### Contact
If you have questions, requests, or bugs to report, please email
<iaguilaror@gmail.com>

#### Dev Team
Israel Aguilar-Ordonez <iaguilaror@gmail.com>   
