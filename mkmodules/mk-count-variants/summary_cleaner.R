## load libraries
library("dplyr")
library("tidyr")
library("stringr")

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## For debugging only
# args 1 is the raw summary data
# args[1] <- "./test/data/samplechr21_76g_PASS_ANeqorgt150_autosomes_and_XY.filtered.nhomalt.filtered.untangled_multiallelics.anno_dbSNP_vep.variants_summary.tmp"
# args 2 is the $stem string from mk
# args[2] <- "./test/data/samplechr21_76g_PASS_ANeqorgt150_autosomes_and_XY.filtered.nhomalt.filtered.untangled_multiallelics.anno_dbSNP_vep"
# args 3 is the output file
# args[3] <- "./test/data/samplechr21_76g_PASS_ANeqorgt150_autosomes_and_XY.filtered.nhomalt.filtered.untangled_multiallelics.anno_dbSNP_vep.snv-variants_summary.tsv"

## load data
raw_data.df <- read.table(file = args[1], header = T, sep = "\t", stringsAsFactors = F)

## Replace stem in variant_subgroup data
raw_data.df$variant_subgroup <- str_replace(string = raw_data.df$variant_subgroup, pattern = args[2], replacement = "") %>%
  str_replace(pattern = ".filtered.", replacement = "") %>%
  str_replace(pattern = ".tsv.gz", replacement = "")

## work on snv first
snv_raw.df <- raw_data.df %>% filter(str_detect(variant_subgroup, "^snv") )

## split file name to begin categorization
snv_raw.df <- snv_raw.df %>% separate( variant_subgroup, into = c("variant_type","subgroup1","subgroup2"), sep = "\\.", remove = F,
         convert = F, extra = "warn", fill = "right")

## begin working in separate blocks according to variant type and subgroup 1 or 2 ----
## subcategory vector for str matching
subcategory_pattern <- "clinvar|coding_region|dbSNPknown|dbSNPnovel|GeneHancer|GWAScatalog|miRNA|OMIM|PGKB|utr"

# total variant first
total_snv_nofilter.df <- snv_raw.df %>% filter(is.na(subgroup1) & is.na(subgroup2) )
## assign row name and colname
total_snv_nofilter.df$row_nam <- "general (all snv)"
total_snv_nofilter.df$col_nam <- "No_filter"

## other total counts in filtered data
total_snv_filtered_snv.df <- snv_raw.df %>%
  filter(!str_detect(subgroup1, pattern = subcategory_pattern) & is.na(subgroup2) )
## assign row name and colname
total_snv_filtered_snv.df$row_nam <- "general (all snv)"
total_snv_filtered_snv.df$col_nam <- total_snv_filtered_snv.df$subgroup1

# no filter datas
no_filter_snv.df <- snv_raw.df %>%
  filter(str_detect(subgroup1, pattern = subcategory_pattern) & is.na(subgroup2) )
## assign row name and colname
no_filter_snv.df$row_nam <- no_filter_snv.df$subgroup1
no_filter_snv.df$col_nam <- "No_filter"

## filtered data not total counts
filtered_snv.df <- snv_raw.df %>% filter(!is.na(subgroup1) & !is.na(subgroup2) )
## assign row name and colname
filtered_snv.df$row_nam <- filtered_snv.df$subgroup2
filtered_snv.df$col_nam <- filtered_snv.df$subgroup1

## paste all long format dataframes
long_snv.df <- rbind(total_snv_nofilter.df, total_snv_filtered_snv.df, no_filter_snv.df, filtered_snv.df) %>%
  select(row_nam, col_nam, counts)

## long to wide format
wide_snv.df <- spread( long_snv.df, col_nam, counts) %>% arrange(No_filter)

## memory clean
rm(filtered_snv.df)
rm(no_filter_snv.df)
rm(snv_raw.df)
rm(total_snv_filtered_snv.df)
rm(total_snv_nofilter.df)
rm(long_snv.df)

### operate on indel data -----
indel_raw.df <- raw_data.df %>% filter(str_detect(variant_subgroup, "^indel") )

## split file name to begin categorization
indel_raw.df <- indel_raw.df %>% separate( variant_subgroup, into = c("variant_type","subgroup1","subgroup2"), sep = "\\.", remove = F,
                                       convert = F, extra = "warn", fill = "right")

## begin working in separate blocks according to variant type and subgroup 1 or 2 ----

# total variant first
total_indel_nofilter.df <- indel_raw.df %>% filter(is.na(subgroup1) & is.na(subgroup2) )
## assign row name and colname
total_indel_nofilter.df$row_nam <- "general (all indels)"
total_indel_nofilter.df$col_nam <- "No_filter"

## other total counts in filtered data
total_indel_filtered_indel.df <- indel_raw.df %>%
  filter(!str_detect(subgroup1, pattern = subcategory_pattern) & is.na(subgroup2) )
## assign row name and colname
total_indel_filtered_indel.df$row_nam <- "general (all indels)"
total_indel_filtered_indel.df$col_nam <- total_indel_filtered_indel.df$subgroup1

# no filter datas
no_filter_indel.df <- indel_raw.df %>%
  filter(str_detect(subgroup1, pattern = subcategory_pattern) & is.na(subgroup2) )
## assign row name and colname
no_filter_indel.df$row_nam <- no_filter_indel.df$subgroup1
no_filter_indel.df$col_nam <- "No_filter"

## filtered data not total counts
filtered_indel.df <- indel_raw.df %>% filter(!is.na(subgroup1) & !is.na(subgroup2) )
## assign row name and colname
filtered_indel.df$row_nam <- filtered_indel.df$subgroup2
filtered_indel.df$col_nam <- filtered_indel.df$subgroup1

## paste all long format dataframes
long_indel.df <- rbind(total_indel_nofilter.df, total_indel_filtered_indel.df, no_filter_indel.df, filtered_indel.df) %>%
  select(row_nam, col_nam, counts)

## long to wide format
wide_indel.df <- spread( long_indel.df, col_nam, counts) %>% arrange(No_filter)

## memory clean
rm(filtered_indel.df)
rm(no_filter_indel.df)
rm(indel_raw.df)
rm(total_indel_filtered_indel.df)
rm(total_indel_nofilter.df)
rm(long_indel.df)

## save data ----
# indel
write.table(x = wide_indel.df,
            file = gsub(args[3], pattern = "snv-variants_summary", replacement = "indel-variants_summary"),
            append = F,quote = F, sep = "\t", row.names = F, col.names = T)
# snv
write.table(x = wide_snv.df, file = args[3], append = F, quote = F, sep = "\t", row.names = F, col.names = T)