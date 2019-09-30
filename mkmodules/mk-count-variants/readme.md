# mk-count-variants
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Count variants by using "summary_cleaner.R" tool.

* Summary_cleaner.R is a tool for counting variants from different types and subgroups. 

*Outputs will be compressed.

## Module Dependencies:
summary_cleaner.R 

### Input(s):

A compressed `.tsv.gz` file extension with the columns of the VEP annotation process separated by tabs.


Example line(s):
```
CHROM	POS	ID	REF	ALT	AC	AN	DP	AF_mx	nhomalt_mx	Allele	Consequence	IMPACT	SYMBOL	Gene	Feature_type	Feature	BIOTYPE	EXON	INTRON	HGVSc	HGVSp	cDNA_position	CDS_position	Protein_position	Amino_acids	Codons	Existing_variation	DISTANCE	STRAND	FLAGS	VARIANT_CLASS	SYMBOL_SOURCE	HGNC_ID	CANONICAL	TSL	APPRIS	CCDS	ENSP	SWISSPROT	TREMBL	UNIPARC	SOURCE	GENE_PHENO	SIFT	PolyPhen	DOMAINS	HGVS_OFFSET	HGVSg	AF	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	AA_AF	EA_AF	gnomAD_AF	gnomAD_AFR_AF	gnomAD_AMR_AF	gnomAD_ASJ_AF	gnomAD_EAS_AF	gnomAD_FIN_AF	gnomAD_NFE_AF	gnomAD_OTH_AF	gnomAD_SAS_AF	MAX_AF	MAX_AF_POPS	CLIN_SIG	SOMATIC	PHENO	PUBMED	MOTIF_NAME	MOTIF_POS	HIGH_INF_POS	MOTIF_SCORE_CHANGE	CADD_PHRED	CADD_RAW	GeneHancer_type_and_Genes	gnomADg	gnomADg_AC	gnomADg_AN	gnomADg_AF	gnomADg_DP	gnomADg_AC_nfe_seu	gnomADg_AN_nfe_seu	gnomADg_AF_nfe_seu	gnomADg_nhomalt_nfe_seu	gnomADg_AC_raw	gnomADg_AN_raw	gnomADg_AF_raw	gnomADg_nhomalt_raw	gnomADg_AC_afr	gnomADg_AN_afr	gnomADg_AF_afr	gnomADg_nhomalt_afr	gnomADg_AC_nfe_onf	gnomADg_AN_nfe_onf	gnomADg_AF_nfe_onf	gnomADg_nhomalt_nfe_onf	gnomADg_AC_amr	gnomADg_AN_amr	gnomADg_AF_amr	gnomADg_nhomalt_amr	gnomADg_AC_eas	gnomADg_AN_eas	gnomADg_AF_eas	gnomADg_nhomalt_eas	gnomADg_nhomalt	gnomADg_AC_nfe_nwe	gnomADg_AN_nfe_nwe	gnomADg_AF_nfe_nwe	gnomADg_nhomalt_nfe_nwe	gnomADg_AC_nfe_est	gnomADg_AN_nfe_est	gnomADg_AF_nfe_est	gnomADg_nhomalt_nfe_est	gnomADg_AC_nfe	gnomADg_AN_nfe	gnomADg_AF_nfe	gnomADg_nhomalt_nfe	gnomADg_AC_fin	gnomADg_AN_fin	gnomADg_AF_fin	gnomADg_nhomalt_fin	gnomADg_AC_asj	gnomADg_AN_asj	gnomADg_AF_asj	gnomADg_nhomalt_asj	gnomADg_AC_oth	gnomADg_AN_oth	gnomADg_AF_oth	gnomADg_nhomalt_oth	gnomADg_popmax	gnomADg_AC_popmax	gnomADg_AN_popmax	gnomADg_AF_popmax	gnomADg_nhomalt_popmax	gnomADg_cov	gwascatalog	gwascatalog_GWAScat_DISEASE_or_TRAIT	gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE	gwascatalog_GWAScat_REPLICATION_SAMPLE_SIZE	gwascatalog_GWAScat_STRONGEST_SNP_and_RISK_ALLELE	gwascatalog_GWAScat_PVALUE	gwascatalog_GWAScat_STUDY_ACCESSION	clinvar	clinvar_CLNDN	clinvar_CLNSIG	clinvar_CLNDISDB	miRBase	pharmgkb_drug	pharmgkb_drug_PGKB_Annotation_ID	pharmgkb_drug_PGKB_Gene	pharmgkb_drug_PGKB_Chemical	pharmgkb_drug_PGKB_PMID	pharmgkb_drug_PGKB_Phenotype_Category	pharmgkb_drug_PGKB_Sentence
chr21	44287632	rs3214074	CA	C	21	152	2257	0.135	2	-	intron_variant	MODIFIER	AIRE	ENSG00000160224	Transcript	ENST00000291582.6	protein_coding	.	4/13	ENST00000291582.6:c.538+42del	.	.	.	.	.	.	rs3214074	.	1	.	deletion	HGNC	HGNC:360	YES	1	P1	CCDS13706.1	ENSP00000291582	O43918	.	UPI0000030FA6	.	1	.	.	.	.	chr21:g.44287633del	.	.	.	.	.	.	0.1826	0.003102	0.05318	0.1878	0.05567	0.01544	0.3574	0.01236	0.002053	0.02742	0.0255	0.3574	gnomAD_EAS	uncertain_significance	.	1	.	.	.	.	.	0.572	-0.133476	.	rs3214074	2321	31290	0.0741771	631635	1	106	0.00943396	0	2349	31416	0.0747708	260	1583	8664	0.18271	146	12	2136	0.00561798	0	44	848	0.0518868	0	570	1544	0.369171	106	252	12	8582	0.00139828	0	44	4568	0.00963222	0	69	15392	0.00448285	0	23	3468	0.00663206	0	5	290	0.0172414	0	27	1084	0.0249077	0	eas	570	1544	0.369171	106	28.76	.	.	.	.	.	.	.	chr21:44287633-44287634	_type_1	Uncertain_significance	MedGen:C0085859&OMIM:240300&Orphanet:ORPHA3453&SNOMED_CT:11244009	.	.	.	.	.	.	.	.
```


### Output:

A `.tsv` the description of the counted variants by each subgroup of variants.

Example line(s):

```
row_nam	common_freq	commonAMR_lowEUR	low_freq	lowEAS_lowEUR	No_filter	rare_freq	selection_signals
miRNA	0	0	0	0	0	0	0
PGKB	0	0	0	0	0	0	0
GWAScatalog	3	0	0	0	3	0	0
OMIM	6	2	1	0	9	2	0
coding_region	7	0	1	1	19	11	0
clinvar	16	2	2	0	21	3	0
utr	90	5	26	7	161	45	0
dbSNPnovel	35	2	114	3	977	828	0
GeneHancer	599	44	187	47	1033	247	0
dbSNPknown	8995	746	2706	567	14586	2885	0
general (all indels)	9030	748	2820	570	15563	3713	0
```

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-count-variants directory structure

````
mk-count-variants /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── summary_cleaner.R					 ## Script used in this module.
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

