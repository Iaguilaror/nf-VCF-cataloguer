#!/usr/bin/env nextflow

/*================================================================
The MORETT LAB presents...

  The VCF categorizer and table descriptor

- A variants description tool for easy prioritizing of variant study

==================================================================
Version: 0.0.1
Project repository: https://github.com/Iaguilaror/nf-vcf-cataloguer.git
==================================================================
Authors:

- Bioinformatics Design
 Israel Aguilar-Ordonez (iaguilaror@gmail)

- Bioinformatics Development
 Israel Aguilar-Ordonez (iaguilaror@gmail)
 Judith Ballesteros-Villascán (judith.vballesteros@gmail)

- Nextflow Port
 Israel Aguilar-Ordonez (iaguilaror@gmail)
 Judith Ballesteros-Villascán (judith.vballesteros@gmail)

=============================
Pipeline Processes In Brief:

Pre-processing:
	_pre1_custom_filter
  _pre2_separate_snv_indel
  _pre3s1_separate_rare_low_common_freq
  _pre3s2_separate_selection_signals
  _pre3s3_separate_lowEAS_lowEUR
  _pre3s4_separate_commonAMR_lowEUR

Core-processing:
  _001_get_clinvar_omim
  _002_get_GeneHancer
  _003_get_GWASCatalog
  _004_get_miRNA
  _005_get_novel_and_known
  _006_get_coding
	_007_get_PGKB
	_008_get_utr

Post-processing:
  _pos1_vcf2tsv
	_pos2_count_variants
	_pos4_organize_vcfs
	_pos5_QC_vep_consequence_plot

================================================================*/

/* Define the help message as a function to call when needed *//////////////////////////////
def helpMessage() {
	log.info"""
  ==========================================
  The VCF categorizer and table descriptor
  - A variants description tool for easy prioritizing of variant study
  v${version}
  ==========================================

	Usage:

  nextflow run categorize-vcf.nf --vcf <path to input 1> [--output_dir path to results]

    --vcf    <- VEP extended and gz compressed vcf file;
		    vcf must be in .vcf.gz format;
        vcf file must have been annotated using the following pipeline: https://bitbucket.org/morett_lab/nf-vcf-annotation/src/master/
    --output_dir     <- directory where results, intermediate and log files will be stored;
				default: same level dir where --vcf_dir resides
	  --help           <- Show Pipeline Information
	  --version        <- Show Pipeline version
	""".stripIndent()
}

/*//////////////////////////////
  Define pipeline version
  If you bump the number, remember to bump it in the header description at the begining of this script too
*/
version = "0.0.1"

/*//////////////////////////////
  Define pipeline Name
  This will be used as a name to include in the results and intermediates directory names
*/
pipeline_name = "catgorizeVCF"

/*
  Initiate default values for parameters
  to avoid "WARN: Access to undefined parameter" messages
*/
params.vcf = false  //if no inputh path is provided, value is false to provoke the error during the parameter validation block
params.help = false //default is false to not trigger help message automatically at every run
params.version = false //default is false to not trigger version message automatically at every run

/*//////////////////////////////
  If the user inputs the --help flag
  print the help message and exit pipeline
*/
if (params.help){
	helpMessage()
	exit 0
}

/*//////////////////////////////
  If the user inputs the --version flag
  print the pipeline version
*/
if (params.version){
	println "VCF categorizer and table description Pipeline v${version}"
	exit 0
}

/*//////////////////////////////
  Define the Nextflow version under which this pipeline was developed or successfuly tested
  Updated by iaguilar at FEB 2019
*/
nextflow_required_version = '19.01'
/*
  Try Catch to verify compatible Nextflow version
  If user Nextflow version is lower than the required version pipeline will continue
  but a message is printed to tell the user maybe it's a good idea to update her/his Nextflow
*/
try {
	if( ! nextflow.version.matches(">= $nextflow_required_version") ){
		throw GroovyException('Your Nextflow version is older than Extend Align required version')
	}
} catch (all) {
	log.error "-----\n" +
			"  Pipeline requires Nextflow version: $nextflow_required_version \n" +
      "  But you are running version: $workflow.nextflow.version \n" +
			"  Pipeline will continue but some things may not work as intended\n" +
			"  You may want to run `nextflow self-update` to update Nextflow\n" +
			"============================================================"
}

/*//////////////////////////////
  INPUT PARAMETER VALIDATION BLOCK
  TODO (iaguilar) check the extension of input queries; see getExtension() at https://www.nextflow.io/docs/latest/script.html#check-file-attributes
*/

/* Check if vcf file was provided
    if they were not provided, they keep the 'false' value assigned in the parameter initiation block above
    and this test fails
*/
if ( !params.vcf ) {
  log.error " Please provide the --vcf file \n\n" +
  " For more information, execute: nextflow run categorize-vcf.nf --help"
  exit 1
}

/*
Output directory definition
Default value to create directory is the parent dir of --vcf
*/
params.output_dir = file(params.vcf).getParent()

/*
  Results and Intermediate directory definition
  They are always relative to the base Output Directory
  and they always include the pipeline name in the variable (pipeline_name) defined by this Script

  This directories will be automatically created by the pipeline to store files during the run
*/
results_dir = "${params.output_dir}/${pipeline_name}-results/"
intermediates_dir = "${params.output_dir}/${pipeline_name}-intermediate/"

/*//////////////////////////////
  LOG RUN INFORMATION
*/
log.info"""
==========================================
The gnomAD liftover pipeline
- A genome coordinates convertion tool
v${version}
==========================================
"""
log.info "--Nextflow metadata--"
/* define function to store nextflow metadata summary info */
def nfsummary = [:]
/* log parameter values beign used into summary */
/* For the following runtime metadata origins, see https://www.nextflow.io/docs/latest/metadata.html */
nfsummary['Resumed run?'] = workflow.resume
nfsummary['Run Name']			= workflow.runName
nfsummary['Current user']		= workflow.userName
/* string transform the time and date of run start; remove : chars and replace spaces by underscores */
nfsummary['Start time']			= workflow.start.toString().replace(":", "").replace(" ", "_")
nfsummary['Script dir']		 = workflow.projectDir
nfsummary['Working dir']		 = workflow.workDir
nfsummary['Current dir']		= workflow.launchDir
nfsummary['Launch command'] = workflow.commandLine
log.info nfsummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "\n\n--Pipeline Parameters--"
/* define function to store nextflow metadata summary info */
def pipelinesummary = [:]
/* log parameter values beign used into summary */
pipelinesummary['VCF file']			= params.vcf
pipelinesummary['Results Dir']		= results_dir
pipelinesummary['Intermediate Dir']		= intermediates_dir
/* print stored summary info */
log.info pipelinesummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "==========================================\nPipeline Start"

/*//////////////////////////////
  PIPELINE START
*/

/*
	DEFINE PATHS TO MK MODULES
  -- every required file (mainly runmk.sh and mkfile, but also every accessory script)
  will be moved from this paths into the corresponding process work subdirectory during pipeline execution
  The use of ${workflow.projectDir} metadata guarantees that mkmodules
  will always be retrieved from a path relative to this NF script
*/

/* _pre1_custom_filter */
module_mk_pre1_custom_filter = "${workflow.projectDir}/mkmodules/mk-custom-filter"

/* _pre2_separate_snv_indel */
module_mk_pre2_separate_snv_indel = "${workflow.projectDir}/mkmodules/mk-separate-snv-indel"

/* _pre3s1_separate_rare_low_common_freq */
module_mk_pre3s1_separate_rare_low_common_freq = "${workflow.projectDir}/mkmodules/mk-separate-rare-low-common-freq"

/* _pre3s2_separate_selection_signals */
module_mk_pre3s2_separate_selection_signals = "${workflow.projectDir}/mkmodules/mk-separate-selection-signals"

/* _pre3s3_separate_lowEAS_lowEUR */

module_mk_pre3s3_separate_lowEAS_lowEUR = "${workflow.projectDir}/mkmodules/mk-separate-lowEAS-lowEUR"
/* _pre3s4_separate_commonAMR_lowEUR */
module_mk_pre3s4_separate_commonAMR_lowEUR = "${workflow.projectDir}/mkmodules/mk-separate-commonAMR-lowEUR"


/* _001_get_clinvar_omim */
module_mk_001_get_clinvar_omim = "${workflow.projectDir}/mkmodules/mk-get-clinvar-omim"

/* _002_get_GeneHancer */
module_mk_002_get_GeneHancer = "${workflow.projectDir}/mkmodules/mk-get-GeneHancer-variants"

/* _003_get_GWASCatalog */
module_mk_003_get_GWASCatalog = "${workflow.projectDir}/mkmodules/mk-get-GWAScatalog-variants"

/* _004_get_miRNA */
module_mk_004_get_miRNA = "${workflow.projectDir}/mkmodules/mk-get-miRNA-variants"

/* _005_get_novel_and_known */
module_mk_005_get_novel_and_known = "${workflow.projectDir}/mkmodules/mk-get-novel-known"

/* _006_get_coding */
module_mk_006_get_coding = "${workflow.projectDir}/mkmodules/mk-get-coding-region-variants"

/* _007_get_PGKB */
module_mk_007_get_PGKB = "${workflow.projectDir}/mkmodules/mk-get-PGKB-variants"

/* _pos1_vcf2tsv */
module_mk_pos1_vcf2tsv = "${workflow.projectDir}/mkmodules/mk-vcf2tsv"

/* _pos2_count_variants */
module_mk_pos2_count_variants = "${workflow.projectDir}/mkmodules/mk-count-variants"

/*
	READ INPUTS
*/
/* Load vcf file into channel */
Channel
  .fromPath("${params.vcf}")
  .set{ vcf_input }

/* _pre1_custom_filter */
/* Read mkfile module files */
Channel
	.fromPath("${module_mk_pre1_custom_filter}/*")
	.toList()
	.set{ mkfiles_pre1 }

process _pre1_custom_filter {

	publishDir "${intermediates_dir}/_pre1_custom_filter/",mode:"symlink"

	input:
  file vcf from vcf_input
	file mk_files from mkfiles_pre1

	output:

	file "*.vcf" into results_pre1_custom_filter, also_results_pre1_custom_filter
	"""
	export AN_CUTOFF="${params.an_cutoff}"
	bash runmk.sh
	"""

}

/* _pre2_separate_snv_indel */
/* Read mkfile module files */
Channel
	.fromPath("${module_mk_pre2_separate_snv_indel}/*")
	.toList()
	.set{ mkfiles_pre2 }

process _pre2_separate_snv_indel {

	publishDir "${intermediates_dir}/_pre2_separate_snv_indel/",mode:"symlink"

	input:
  file vcf from results_pre1_custom_filter
	file mk_files from mkfiles_pre2

	output:
  /* First series of output chanel is primary split of data */
	file "*.vcf" into results_pre2_separate_snv_indel, also_results_pre2_separate_snv_indel, again_results_pre2_separate_snv_indel, more_results_pre2_separate_snv_indel mode flatten
  /* Second channel series is for the variant categorization block, countig varin categories in all snvs and all indels */
  file "*.vcf" into pre2_results_for_001, pre2_results_for_002, pre2_results_for_003, pre2_results_for_004, pre2_results_for_005, pre2_results_for_006, pre2_results_for_007, pre2_results_for_008 mode flatten
	/* Third channel is for direct vcf2tsv conversion*/
	file "*.vcf" into pre2_results_for_pos1
  """
	bash runmk.sh
	"""

}

/* _pre3s1_separate_rare_low_common_freq */
/* Read mkfile module files */
Channel
	.fromPath("${module_mk_pre3s1_separate_rare_low_common_freq}/*")
	.toList()
	.set{ mkfiles_pre3s1 }

process _pre3s1_separate_rare_low_common_freq {

	publishDir "${intermediates_dir}/_pre3s1_separate_rare_low_common_freq/",mode:"symlink"

	input:
  file vcf from results_pre2_separate_snv_indel
	file mk_files from mkfiles_pre3s1

	output:
  file "*.vcf" into pre3s1_results_for_001, pre3s1_results_for_002, pre3s1_results_for_003, pre3s1_results_for_004, pre3s1_results_for_005, pre3s1_results_for_006, pre3s1_results_for_007, pre3s1_results_for_008 mode flatten
	/* Second channel is for direct vcf2tsv conversion*/
	file "*.vcf" into pre3s1_results_for_pos1
	"""
	bash runmk.sh
	"""


}
/* _pre3s2_separate_selection_signals */
/* Read mkfile module files */
Channel
	.fromPath("${module_mk_pre3s2_separate_selection_signals}/*")
	.toList()
	.set{ mkfiles_pre3s2 }

process _pre3s2_separate_selection_signals {

	publishDir "${intermediates_dir}/_pre3s2_separate_selection_signals/",mode:"symlink"

	input:
  file vcf from also_results_pre2_separate_snv_indel
	file mk_files from mkfiles_pre3s2

	output:
	file "*.vcf" into pre3s2_results_for_001, pre3s2_results_for_002, pre3s2_results_for_003, pre3s2_results_for_004, pre3s2_results_for_005, pre3s2_results_for_006, pre3s2_results_for_007, pre3s2_results_for_008 mode flatten
	/* Second channel is for direct vcf2tsv conversion*/
	file "*.vcf" into pre3s2_results_for_pos1

	"""
	export RSID_LIST="${params.rsid_list}"
	bash runmk.sh
	"""

}

/* _pre3s3_separate_lowEAS_lowEUR */
/* Read mkfile module files */
Channel
	.fromPath("${module_mk_pre3s3_separate_lowEAS_lowEUR}/*")
	.toList()
	.set{ mkfiles_pre3s3 }

process _pre3s3_separate_lowEAS_lowEUR {

	publishDir "${intermediates_dir}/_pre3s3_separate_lowEAS_lowEUR/",mode:"symlink"

	input:
  file vcf from again_results_pre2_separate_snv_indel
	file mk_files from mkfiles_pre3s3

	output:
	file "*.vcf" into pre3s3_results_for_001, pre3s3_results_for_002, pre3s3_results_for_003, pre3s3_results_for_004, pre3s3_results_for_005, pre3s3_results_for_006, pre3s3_results_for_007, pre3s3_results_for_008 mode flatten
	/* Second channel is for direct vcf2tsv conversion*/
	file "*.vcf" into pre3s3_results_for_pos1
	"""
	bash runmk.sh
	"""

}

/* _pre3s4_separate_commonAMR_lowEUR */
/* Read mkfile module files */
Channel
	.fromPath("${module_mk_pre3s4_separate_commonAMR_lowEUR}/*")
	.toList()
	.set{ mkfiles_pre3s4 }

process _pre3s4_separate_commonAMR_lowEUR {

	publishDir "${intermediates_dir}/_pre3s4_separate_commonAMR_lowEUR/",mode:"symlink"

	input:
  file vcf from more_results_pre2_separate_snv_indel
	file mk_files from mkfiles_pre3s4

	output:
	file "*.vcf" into pre3s4_results_for_001, pre3s4_results_for_002, pre3s4_results_for_003, pre3s4_results_for_004, pre3s4_results_for_005, pre3s4_results_for_006, pre3s4_results_for_007, pre3s4_results_for_008 mode flatten
	/* Second channel is for direct vcf2tsv conversion*/
	file "*.vcf" into pre3s4_results_for_pos1
	"""
	bash runmk.sh
	"""

}

/* _001_get_clinvar_omim */
/* preprocessing inputs */
/* Gather all results for 001 */
pre2_results_for_001
	.mix(pre3s1_results_for_001, pre3s2_results_for_001, pre3s3_results_for_001, pre3s4_results_for_001)
	.set{ inputs_001 }

/* Read mkfile module files */
Channel
	.fromPath("${module_mk_001_get_clinvar_omim}/*")
	.toList()
	.set{ mkfiles_001 }

process _001_get_clinvar_omim {

	publishDir "${intermediates_dir}/_001_get_clinvar_omim/",mode:"symlink"

	input:
  file vcf from inputs_001
	file mk_files from mkfiles_001

	output:
	file "*.vcf" into results_001_get_clinvar_omim mode flatten
	"""
	bash runmk.sh
	"""

}

/* _002_get_GeneHancer */
/* preprocessing inputs */
/* Gather all results for 002 */
pre2_results_for_002
	.mix(pre3s1_results_for_002, pre3s2_results_for_002, pre3s3_results_for_002, pre3s4_results_for_002)
	.set{ inputs_002 }

/* Read mkfile module files */
Channel
	.fromPath("${module_mk_002_get_GeneHancer}/*")
	.toList()
	.set{ mkfiles_002 }

process _002_get_GeneHancer {

	publishDir "${intermediates_dir}/_002_get_GeneHancer/",mode:"symlink"

	input:
  file vcf from inputs_002
	file mk_files from mkfiles_002

	output:
	file "*.vcf" into results_002_get_GeneHancer mode flatten
	"""
	bash runmk.sh
	"""

}

/* _003_get_GWASCatalog */
/* preprocessing inputs */
/* Gather all results for 003 */
pre2_results_for_003
	.mix(pre3s1_results_for_003, pre3s2_results_for_003, pre3s3_results_for_003, pre3s4_results_for_003)
	.set{ inputs_003 }

/* Read mkfile module files */
Channel
	.fromPath("${module_mk_003_get_GWASCatalog}/*")
	.toList()
	.set{ mkfiles_003 }

process _003_get_GWASCatalog {

	publishDir "${intermediates_dir}/_003_get_GWASCatalog/",mode:"symlink"

	input:
  file vcf from inputs_003
	file mk_files from mkfiles_003

	output:
	file "*.vcf" into results_003_get_GWASCatalog mode flatten
	"""
	bash runmk.sh
	"""

}

/* _004_get_miRNA */
/* preprocessing inputs */
/* Gather all results for 004 */
pre2_results_for_004
	.mix(pre3s1_results_for_004, pre3s2_results_for_004, pre3s3_results_for_004, pre3s4_results_for_004)
	.set{ inputs_004 }

/* Read mkfile module files */
Channel
	.fromPath("${module_mk_004_get_miRNA}/*")
	.toList()
	.set{ mkfiles_004 }

process _004_get_miRNA {

	publishDir "${intermediates_dir}/_004_get_miRNA/",mode:"symlink"

	input:
  file vcf from inputs_004
	file mk_files from mkfiles_004

	output:
	file "*.vcf" into results_004_get_miRNA mode flatten
	"""
	bash runmk.sh
	"""

}

/* _005_get_novel_and_known */
/* preprocessing inputs */
/* Gather all results for 005 */
pre2_results_for_005
	.mix(pre3s1_results_for_005, pre3s2_results_for_005, pre3s3_results_for_005, pre3s4_results_for_005)
	.set{ inputs_005 }

/* Read mkfile module files */
Channel
	.fromPath("${module_mk_005_get_novel_and_known}/*")
	.toList()
	.set{ mkfiles_005 }

process _005_get_novel_and_known {

	publishDir "${intermediates_dir}/_005_get_novel_and_known/",mode:"symlink"

	input:
  file vcf from inputs_005
	file mk_files from mkfiles_005

	output:
	file "*.vcf" into results_005_get_novel_and_known mode flatten
	"""
	bash runmk.sh
	"""

}

/* _006_get_coding */
/* preprocessing inputs */
/* Gather all results for 006 */
pre2_results_for_006
	.mix(pre3s1_results_for_006, pre3s2_results_for_006, pre3s3_results_for_006, pre3s4_results_for_006)
	.set{ inputs_006 }

/* Read mkfile module files */
Channel
	.fromPath("${module_mk_006_get_coding}/*")
	.toList()
	.set{ mkfiles_006 }

process _006_get_coding {

	publishDir "${intermediates_dir}/_006_get_coding/",mode:"symlink"

	input:
  file vcf from inputs_006
	file mk_files from mkfiles_006

	output:
	file "*.vcf" into results_006_get_coding mode flatten
	"""
	bash runmk.sh
	"""

}

/// WORKING BLOCK

/* _007_get_PGKB */
/* preprocessing inputs */
/* Gather all results for 007 */
pre2_results_for_007
	.mix(pre3s1_results_for_007, pre3s2_results_for_007, pre3s3_results_for_007, pre3s4_results_for_007)
	.set{ inputs_007 }

/* Read mkfile module files */
Channel
	.fromPath("${module_mk_007_get_PGKB}/*")
	.toList()
	.set{ mkfiles_007 }

process _007_get_PGKB {

	publishDir "${intermediates_dir}/_007_get_PGKB/",mode:"symlink"

	input:
  file vcf from inputs_007
	file mk_files from mkfiles_007

	output:
	file "*.vcf" into results_007_get_PGKB mode flatten
	"""
	bash runmk.sh
	"""

}

/// END WORKING BLOCK

/* _008_get_utr */
/* preprocessing inputs */
/* Gather all results for 008 */
pre2_results_for_008
	.mix(pre3s1_results_for_008, pre3s2_results_for_008, pre3s3_results_for_008, pre3s4_results_for_008)
	.set{ inputs_008 }

/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-get-utr-variants/*")
	.toList()
	.set{ mkfiles_008 }

process _008_get_utr {

	publishDir "${intermediates_dir}/_008_get_utr/",mode:"symlink"

	input:
  file vcf from inputs_008
	file mk_files from mkfiles_008

	output:
	file "*.vcf" into results_008_get_utr mode flatten
	"""
	bash runmk.sh
	"""

}

////////////////

/* _pos1_vcf2tsv */
/* preprocessing inputs */
/* Gather all results from 001 - 005 */
/* also include results from pre2, pre3s1, pre3s2, pre3s3, and pre3s4*/
results_001_get_clinvar_omim
	.mix(results_002_get_GeneHancer, results_003_get_GWASCatalog, results_004_get_miRNA, results_005_get_novel_and_known, results_006_get_coding, results_007_get_PGKB, results_008_get_utr)
	.mix(pre2_results_for_pos1, pre3s1_results_for_pos1, pre3s2_results_for_pos1, pre3s3_results_for_pos1, pre3s4_results_for_pos1)
	.into{ inputs_pos1; pre_inputs_pos4 }

/* Read mkfile module files */
Channel
	.fromPath("${module_mk_pos1_vcf2tsv}/*")
	.toList()
	.set{ mkfiles_pos1 }

process _pos1_vcf2tsv {

	publishDir "${results_dir}/_pos1_vcf2tsv/",mode:"copy"
	/* Organize SNV results via publishdir multiple directives */
	publishDir "${results_dir}/export/tsv-tables/snv/100GMX-commonfreq-and-gnomAD-commonfreqAMR-and-lowfreqEUR/",mode:"copy",pattern:"*.snv.commonAMR_lowEUR.*"
	publishDir "${results_dir}/export/tsv-tables/snv/100GMX-commonfreq-and-gnomAD-lowfreqEAS-and-lowfreqEUR/",mode:"copy",pattern:"*.snv.lowEAS_lowEUR.*"
	publishDir "${results_dir}/export/tsv-tables/snv/commonfreq/",mode:"copy",pattern:"*.snv.common_freq.*"
	publishDir "${results_dir}/export/tsv-tables/snv/lowfreq/",mode:"copy",pattern:"*.snv.low_freq.*"
	publishDir "${results_dir}/export/tsv-tables/snv/rarefreq/",mode:"copy",pattern:"*.snv.rare_freq.*"
	publishDir "${results_dir}/export/tsv-tables/snv/selection-signals/",mode:"copy",pattern:"*.snv.selection_signals.*"
	publishDir "${results_dir}/export/tsv-tables/snv/uncategorized/",mode:"copy",pattern:"*.snv.{clinvar.tsv.gz,coding_region.tsv.gz,dbSNPknown.tsv.gz,dbSNPnovel.tsv.gz,GeneHancer.tsv.gz,GWAScatalog.tsv.gz,miRNA.tsv.gz,OMIM.tsv.gz,PGKB.tsv.gz,tsv.gz,utr.tsv.gz}"
	/* Organize INDEL results via publishdir multiple directives */
	publishDir "${results_dir}/export/tsv-tables/indel/100GMX-commonfreq-and-gnomAD-commonfreqAMR-and-lowfreqEUR/",mode:"copy",pattern:"*.indel.commonAMR_lowEUR.*"
	publishDir "${results_dir}/export/tsv-tables/indel/100GMX-commonfreq-and-gnomAD-lowfreqEAS-and-lowfreqEUR/",mode:"copy",pattern:"*.indel.lowEAS_lowEUR.*"
	publishDir "${results_dir}/export/tsv-tables/indel/commonfreq/",mode:"copy",pattern:"*.indel.common_freq.*"
	publishDir "${results_dir}/export/tsv-tables/indel/lowfreq/",mode:"copy",pattern:"*.indel.low_freq.*"
	publishDir "${results_dir}/export/tsv-tables/indel/rarefreq/",mode:"copy",pattern:"*.indel.rare_freq.*"
	publishDir "${results_dir}/export/tsv-tables/indel/selection-signals/",mode:"copy",pattern:"*.indel.selection_signals.*"
	publishDir "${results_dir}/export/tsv-tables/indel/uncategorized/",mode:"copy",pattern:"*.indel.{clinvar.tsv.gz,coding_region.tsv.gz,dbSNPknown.tsv.gz,dbSNPnovel.tsv.gz,GeneHancer.tsv.gz,GWAScatalog.tsv.gz,miRNA.tsv.gz,OMIM.tsv.gz,PGKB.tsv.gz,tsv.gz,utr.tsv.gz}"

	input:
  file vcf from inputs_pos1
	file mk_files from mkfiles_pos1

	output:
	file "*.tsv.gz" into results_pos1_vcf2tsv, also_results_pos1_vcf2tsv
	"""
	bash runmk.sh
	"""

}

/* _pos2_count_variants */
/* preprocessing inputs */
/* Gather all results from pos1 */
results_pos1_vcf2tsv
	.flatten()
	.toList()
	.into{ inputs_pos2; inputs_pos3 }

/* Read mkfile module files */
Channel
	.fromPath("${module_mk_pos2_count_variants}/*")
	.toList()
	.set{ mkfiles_pos2 }

process _pos2_count_variants {

	publishDir "${results_dir}/_pos2_count_variants/",mode:"copy"
	publishDir "${results_dir}/export/tsv-tables/counts/",mode:"copy",pattern:"*-variants_summary.tsv"

	input:
  file vcf from inputs_pos2
	file mk_files from mkfiles_pos2

	output:
	file "*-variants_summary.tsv" into results_pos2_count_variants
	"""
	bash runmk.sh
	"""

}

/* _pos4_organize_vcfs */
pre_inputs_pos4
	.mix(also_results_pre1_custom_filter)
	.flatten()
	.toList()
	.set{ inputs_pos4 }

process _pos4_organize_vcfs {

	publishDir "${results_dir}/_pos4_organize_vcfs/",mode:"symlink"
	/* Organize data for export*/
	publishDir "${results_dir}/export/AN-filtered-vcf-files/",mode:"copy", pattern:"*.filtered.vcf.gz*"
	/* Organize SNV for export*/
	publishDir "${results_dir}/export/AN-filtered-vcf-files/snv/",mode:"copy", pattern:"*.filtered.snv.*"
	/* Organize INDEL for export*/
	publishDir "${results_dir}/export/AN-filtered-vcf-files/indel/",mode:"copy", pattern:"*.filtered.indel.*"

	input:
  file vcf from inputs_pos4

	output:
	file "*.vcf.gz*"

	"""
	for ifile in *.vcf; do bgzip \$ifile; tabix -p vcf \$ifile.gz; done
	"""

}

/* _pos5_QC_vep_consequence_plot */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-QC-vep-consequence-plot/*")
	.toList()
	.set{ mkfiles_pos5 }

process _pos5_QC_vep_consequence_plot {

	publishDir "${results_dir}/_pos5_QC_vep_consequence_plot/",mode:"copy"

	input:
  file tsv from also_results_pos1_vcf2tsv
	file mk_files from mkfiles_pos5

	output:
	file "*"

	"""
	bash runmk.sh
	"""

}
