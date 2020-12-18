library(ggalluvial)
library(sessioninfo)
library(tidyverse)
library(here)

here()
# Load overlap for HG002 GRCh38 hifiasm v0.11 and 
#v4.2.1 of medically relevant gene coordinates
hifiasm_v11_and_v4.2.1_overlap_df_grch38 <- read_tsv(
    here("data","overlap_analysis", "GRCh38", "GRCh38_overlap_v4.2.1_hifiasm.tsv"),
    col_types = "cddcddddd"
)

mandelker_list <- read_tsv(
    here("data", "mrg_lists","Mandelker_Medically_Relevant_Genes.tsv"),
    col_types = "c")

cosmic_list <- read_tsv(here("data", "mrg_lists", "COSMIC_Gene_Census.tsv"),
                        col_types = "c")

lincoln_list <- read_tsv(
    here("data", "mrg_lists", "Steve_Lincoln_Compiled_Medical_Gene_List.tsv"),
    col_types = "c")


    
# Add columns for different levels of overlap 
hifiasm_v11_and_v421_overlap_df_grch38_mutated <- 
	hifiasm_v11_and_v4.2.1_overlap_df_grch38 %>% 
	mutate(overlap_v4 = ifelse(percent_overlap_v4.2.1 < .9, 
							   "v4_lt_90",
							   "v4_gte_90")) %>%
	mutate(asm_resolved = ifelse(percent_flanking_plus_segdups_overlap_hifiasm == 1 
								 & flanking_breaks_in_dip_bed == 0, 
								 "asm_pass",
								 "asm_fail")) %>%
	mutate(benchmark_membership = ifelse(
		gene %in% union_GRCh37_GRCh38_MRG_candidates_v421_df, 
										 "in_bench",
										 "outside_bench")) %>%
	mutate(benchmark_membership = ifelse(
		gene %in% union_GRCh37_GRCh38_MRG_candidates_v421_df, 
										 "in_bench",
										 "not_in_bench")) %>%
	mutate(mandelker_membership = ifelse(
		gene %in% mandelker_list$Gene, "in_mandelker",
										"not_in_mandelker")) %>%
	mutate(cosmic_membership = ifelse(gene %in% cosmic_list$Gene, 
									  "in_cosmic",
								      "not_in_cosmic"))	%>%
	mutate(lincoln_membership = ifelse(gene %in% lincoln_list$Gene, 
									   "in_lincoln",
									   "not_in_lincoln"))

alluvial_levels <- c("gene","overlap_v4",
					 "asm_resolved", 
					 "benchmark_membership", 
					 "mandelker_membership", 
					 "cosmic_membership", 
					 "lincoln_membership")

hifiasm_v11_and_v421_overlap_df_grch38_mutated_final <- 
	hifiasm_v11_and_v421_overlap_df_grch38_mutated[,alluvial_levels]

# Modified from Titanic figure in
# https://cran.r-project.org/web/packages/ggalluvial/vignettes/ggalluvial.html
ggplot(as.data.frame(hifiasm_v11_and_v421_overlap_df_grch38_mutated_final),
	   aes(y = gene,
	   	axis1 = mandelker_membership, 
	   	axis2 = cosmic_membership,
	   	axis3 = lincoln_membership,
	   	axis4 = overlap_v4,
	   	axis5 = asm_resolved,
	   	axis6 = benchmark_membership)) +
	geom_alluvium(width = 0, knot.pos = 0, reverse = FALSE) +
	guides(fill = FALSE) +
	geom_stratum(width = 1/8, reverse = FALSE) +
	geom_text(stat = "stratum", aes(label = after_stat(stratum)),
			  reverse = FALSE) +
	scale_x_continuous(breaks = 1:6, labels = c("mandelker_membership", 
												"cosmic_membership", 
												"lincoln_membership", 
												"overlap_v4", 
												"asm_resolved", 
												"benchmark_membership")) +
	coord_flip() +
	ggtitle("Benchmark generation process")


session_info()

#─ Session info
# setting  value                       
# version  R version 3.6.3 (2020-02-29)
# os       macOS Catalina 10.15.7      
# system   x86_64, darwin15.6.0        
# ui       RStudio                     
# language (EN)                        
# collate  en_US.UTF-8                 
# ctype    en_US.UTF-8                 
# tz       America/New_York            
# date     2020-12-16                  
# 
# ─ Packages
# package     * version date       lib source        
# assertthat    0.2.1   2019-03-21 [1] CRAN (R 3.6.0)
# backports     1.1.5   2019-10-02 [1] CRAN (R 3.6.0)
# broom         0.5.6   2020-04-20 [1] CRAN (R 3.6.2)
# cellranger    1.1.0   2016-07-27 [1] CRAN (R 3.6.0)
# cli           2.0.2   2020-02-28 [1] CRAN (R 3.6.0)
# colorspace    1.4-1   2019-03-18 [1] CRAN (R 3.6.0)
# crayon        1.3.4   2017-09-16 [1] CRAN (R 3.6.0)
# DBI           1.1.0   2019-12-15 [1] CRAN (R 3.6.0)
# dbplyr        1.4.2   2019-06-17 [1] CRAN (R 3.6.0)
# digest        0.6.25  2020-02-23 [1] CRAN (R 3.6.0)
# dplyr       * 0.8.5   2020-03-07 [1] CRAN (R 3.6.0)
# ellipsis      0.3.0   2019-09-20 [1] CRAN (R 3.6.0)
# fansi         0.4.1   2020-01-08 [1] CRAN (R 3.6.0)
# farver        2.0.3   2020-01-16 [1] CRAN (R 3.6.0)
# forcats     * 0.5.0   2020-03-01 [1] CRAN (R 3.6.0)
# fs            1.4.1   2020-04-04 [1] CRAN (R 3.6.2)
# generics      0.0.2   2018-11-29 [1] CRAN (R 3.6.0)
# ggalluvial  * 0.12.3  2020-12-05 [1] CRAN (R 3.6.2)
# ggplot2     * 3.3.0   2020-03-05 [1] CRAN (R 3.6.0)
# glue          1.4.0   2020-04-03 [1] CRAN (R 3.6.3)
# gtable        0.3.0   2019-03-25 [1] CRAN (R 3.6.0)
# haven         2.2.0   2019-11-08 [1] CRAN (R 3.6.0)
# hms           0.5.3   2020-01-08 [1] CRAN (R 3.6.0)
# httr          1.4.1   2019-08-05 [1] CRAN (R 3.6.0)
# jsonlite      1.6.1   2020-02-02 [1] CRAN (R 3.6.0)
# labeling      0.3     2014-08-23 [1] CRAN (R 3.6.0)
# lattice       0.20-41 2020-04-02 [1] CRAN (R 3.6.3)
# lifecycle     0.2.0   2020-03-06 [1] CRAN (R 3.6.0)
# lubridate     1.7.8   2020-04-06 [1] CRAN (R 3.6.2)
# magrittr      1.5     2014-11-22 [1] CRAN (R 3.6.0)
# modelr        0.1.6   2020-02-22 [1] CRAN (R 3.6.0)
# munsell       0.5.0   2018-06-12 [1] CRAN (R 3.6.0)
# nlme          3.1-145 2020-03-04 [1] CRAN (R 3.6.0)
# pillar        1.4.3   2019-12-20 [1] CRAN (R 3.6.0)
# pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 3.6.0)
# purrr       * 0.3.3   2019-10-18 [1] CRAN (R 3.6.0)
# R6            2.4.1   2019-11-12 [1] CRAN (R 3.6.0)
# Rcpp          1.0.4   2020-03-17 [1] CRAN (R 3.6.0)
# readr       * 1.3.1   2018-12-21 [1] CRAN (R 3.6.0)
# readxl        1.3.1   2019-03-13 [1] CRAN (R 3.6.0)
# reprex        0.3.0   2019-05-16 [1] CRAN (R 3.6.0)
# rlang         0.4.5   2020-03-01 [1] CRAN (R 3.6.0)
# rstudioapi    0.11    2020-02-07 [1] CRAN (R 3.6.0)
# rvest         0.3.5   2019-11-08 [1] CRAN (R 3.6.0)
# scales        1.1.1   2020-05-11 [1] CRAN (R 3.6.2)
# sessioninfo * 1.1.1   2018-11-05 [1] CRAN (R 3.6.0)
# stringi       1.4.6   2020-02-17 [1] CRAN (R 3.6.0)
# stringr     * 1.4.0   2019-02-10 [1] CRAN (R 3.6.0)
# tibble      * 3.0.0   2020-03-30 [1] CRAN (R 3.6.2)
# tidyr       * 1.0.2   2020-01-24 [1] CRAN (R 3.6.0)
# tidyselect    1.0.0   2020-01-27 [1] CRAN (R 3.6.0)
# tidyverse   * 1.3.0   2019-11-21 [1] CRAN (R 3.6.0)
# utf8          1.1.4   2018-05-24 [1] CRAN (R 3.6.0)
# vctrs         0.2.4   2020-03-10 [1] CRAN (R 3.6.0)
# withr         2.1.2   2018-03-15 [1] CRAN (R 3.6.0)
# xml2          1.3.2   2020-04-23 [1] CRAN (R 3.6.2)
# yaml          2.2.1   2020-02-01 [1] CRAN (R 3.6.0)