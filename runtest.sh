echo -e "======\n Testing NF execution \n======" \
&& rm -rf test/results/ \
&& nextflow run categorize-vcf.nf \
	--vcf test/data/samplechr21.vcf.gz \
	--output_dir test/results \
	-resume \
	-with-report test/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag test/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n Basic pipeline TEST SUCCESSFUL \n======"
