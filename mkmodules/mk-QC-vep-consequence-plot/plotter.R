## load libraries
library("ggplot2")
library("dplyr")
library("viridis")
library("scales")

## read args from command line
args <- commandArgs(trailingOnly = T)

## For debug purposes
# args[1] <- "test/data/78G.anno_rsid_vep_subsampled.filtered.low_freq.known.tsv.gz"
# args[2] <- "test/data/78G.anno_rsid_vep_subsampled.filtered.low_freq.known.vep_consequence.png"

## Read data
tsv.df <- read.table(file = args[1], header = T, sep = "\t")

## summarize data
summarized.df <- tsv.df %>% group_by(Consequence) %>% summarize(number_of_variants = n())

## rename ofile before saving
ofile_name <- gsub(pattern = ".png.build", replacement = ".tsv", x = args[2])
write.table(x = summarized.df,
            file = ofile_name,
            append = F,
            quote = F,
            sep = "\t",
            row.names = F,
            col.names = T)

## handle df to add percentage to legend tag
summarized.df$Consequence <- as.character(summarized.df$Consequence)
total_variants <- sum(summarized.df$number_of_variants)
summarized.df$legend <- round(summarized.df$number_of_variants / total_variants, digits = 3)
## to percentage
summarized.df$legend <- percent(summarized.df$legend)
## paste name and numbers
summarized.df$legend <- paste(summarized.df$legend, summarized.df$Consequence)
## replace consequence col
# summarized.df$Consequence <- summarized.df$legend
## order data
ordered_levels <- unlist(summarized.df[order(summarized.df$number_of_variants, decreasing = T),"Consequence"])
ordered_labels <- unlist(summarized.df[order(summarized.df$number_of_variants, decreasing = T),"legend"] )

## organize levels
summarized.df$Consequence <- factor(summarized.df$Consequence, levels = ordered_levels)
summarized.df$legend <- factor(summarized.df$legend, levels = ordered_labels)

## plot data
pie.p <- ggplot(summarized.df, aes(x="", y=number_of_variants, fill=legend))+
  geom_bar(width = 0.2, stat = "identity", color = "black") +
  coord_polar("y", start=0) +
  labs(title = "Variant Effect Predictor Consequence Summary", caption = args[1]) +
  scale_fill_manual( values = plasma(nrow(summarized.df))) +
  theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    # plot.title=element_text(size=6, face="bold"),
    plot.title = element_blank(),
    plot.caption = element_text(hjust = 1, size = 5),
    legend.text = element_text(size=5),
    legend.title = element_text(size=6, face="bold"),
    legend.key.height = unit( 0.3, units = "cm"),
    legend.key.width = unit( 0.3, units = "cm")
  )

## save plot
ggsave(filename = args[2], plot = pie.p, device = "png", width = 10.8*1.5, height = 7.2*1.5 , units = "cm", dpi = 600)
