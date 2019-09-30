####
## New file results/78G_Selection_allsig.txt

Provided by Dr. Humberto Garcia @ INMEGEN.
This files contains the first columns with rsIDs for selection signals detected by ihs and PBS (intersected results)

#######

some of the snps with selection signals came in coordinate format, so, we are going to extract the correct coordinates.

Process:

"""
cut -f1 data/91G_ihs_significant_results.txt | grep "^rs[0-9]*" > results/with_rsIDs.tmp	##it has 66846 rsIDs
cut -f1 data/91G_ihs_significant_results.txt | grep -v "^rs[0-9]*" > results/no_rsIDs.tmp	##it has 208 rsIDs
"""

Now, using the vcf of 78G, we are going to look for the rsID of the positions with no_rsIDs.tmp

Process:
"""
for position in $(cat results/no_rsIDs.tmp); do bcftools view -H data/78G.anno_rsid_vep.vcf.gz $position | cut -f3 ;done > results/recovered_rsIDs.tmp
"""

Now, les concatenate the original rsIDs and the recovered ones, and remove duplicate ids:

"""
cat results/with_rsIDs.tmp results/recovered_rsIDs.tmp | sort -u > results/91G_rsIDs_selection_signals_by_ihs.txt
"""

Note: so far, temporary results look like this:
"""
`wc -l`
   208 results/no_rsIDs.tmp
   204 results/recovered_rsIDs.tmp	## 4 positions could not recover any rsID =this means that no position was found, probably because it was filtered out during the data cleaning step
 66846 results/with_rsIDs.tmp

 67050 results/rsIDs_selection_signals_by_ihs.txt  ## THIS is the final file for our pipeline to separate variants with selection signals
"""

clean files:

"""
rm results/*.tmp
"""
