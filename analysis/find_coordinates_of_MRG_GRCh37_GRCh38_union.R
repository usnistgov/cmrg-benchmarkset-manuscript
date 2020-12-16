library(tidyverse)
library(sessioninfo)
`%ni%` <- Negate(`%in%`)

# Load overlap for HG002 GRCh37 hifiasm v0.11 and v4.2.1 of medically relevant gene coordinates
hifiasm_v11_and_v421_overlap_df_grch37 <- read_tsv("GRCh37_overlap_v4.2.1_hifiasm.tsv", col_types = "cddcddddd")

# Find genes that are less than 90% overlap by v4.2.1 but fully covered including flanking and segdups by hifiasm v11
hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch37 <- hifiasm_v11_and_v421_overlap_df_grch37 %>% 
	filter(chrom %in% paste0("", 1:22),
		   percent_flanking_plus_segdups_overlap_hifiasm == 1,
		   percent_overlap_v4.2.1 < 0.9,
		   flanking_breaks_in_dip_bed == 0)

# Load overlap for HG002 GRCh38 hifiasm v0.11 and v4.2.1 of medically relevant gene coordinates
hifiasm_v11_and_v421_overlap_df_grch38 <- read_tsv("GRCh38_overlap_v4.2.1_hifiasm.tsv", col_types = "cddcddddd")

# Find genes that are less than 90% overlap by v4.2.1 but fully covered including flanking and segdups by hifiasm v11
hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch38 <- hifiasm_v11_and_v421_overlap_df_grch38 %>% 
	filter(chrom %in% paste0("chr", 1:22),
		   percent_flanking_plus_segdups_overlap_hifiasm == 1,
		   percent_overlap_v4.2.1 < 0.9,
		   flanking_breaks_in_dip_bed == 0)

union_GRCh37_GRCh38_MRG_candidates_v421_df <- union(hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch37$gene, hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch38$gene)

union_MRG_df_grch37 <- hifiasm_v11_and_v421_overlap_df_grch37 %>% 
	filter(chrom %in% paste0("", 1:22),
		   gene %in% union_GRCh37_GRCh38_MRG_candidates_v421_df,
		   percent_flanking_plus_segdups_overlap_hifiasm == 1,
		   flanking_breaks_in_dip_bed == 0)


union_MRG_df_grch38 <- hifiasm_v11_and_v421_overlap_df_grch38 %>% 
	filter(chrom %in% paste0("chr", 1:22),
		   gene %in% union_GRCh37_GRCh38_MRG_candidates_v421_df,
		   percent_flanking_plus_segdups_overlap_hifiasm == 1,
		   flanking_breaks_in_dip_bed == 0)

# Write bed to file
write_tsv(union_MRG_df_grch37[,1:4], "HG002_GRCh37_Union_MRG.bed", col_names = FALSE)

# Write bed to file
write_tsv(union_MRG_df_grch38[,1:4], "HG002_GRCh38_Union_MRG.bed", col_names = FALSE)

# Genes that are not in ENSEMBL GRCh37
union_GRCh37_GRCh38_MRG_candidates_v421_df[which(union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% hifiasm_v11_and_v421_overlap_df_grch37$gene)]
# "NAPRT"

# Genes that are not in ENSEMBL GRCh38
union_GRCh37_GRCh38_MRG_candidates_v421_df[which(union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% hifiasm_v11_and_v421_overlap_df_grch38$gene)]
# "HEATR2" "TMEM5"  "DYX1C1" "TMEM8A" "CIRH1A"