##===========================================================================
## Author: Jenny McDaniel

## Date: 4/21/21

## Background: 3/30/21 Request from JZ to generate plots for MRG manuscript to 
## show that the performance of 3 HiFi, Illumina, and ONT callsets 
## to show how masking GRCh38 false duplication improves benchmarking.
## Callsets were renamed for plots as follows:
## ONT-minimap2-clair2-HG2-38-.... --> ONT-minimap2-clair2
## HG002_38_nodecoy.... --> 	Illumina-bwamem-GATK
## HiFi-DV-38.... --> HiFi-minimap2-DV

## Data: Benchmarking data (HG002-GRCh38-masking-comparison-stratifications.csv)
## from https://docs.google.com/spreadsheets/d/1smJ-ATsXwko2sCOTh4Lcyi8msnx1FM1zkERacQdHYY0/edit#gid=1746581338
## "GRCh38 mask/nomask" sheet.  This data was generated using mrg_benchmark_eval
## Snakefile_final_evaluation.py which can be found in JM GitLab repo:
## https://gitlab.nist.gov/gitlab/jennifer.mcdaniel/mrg-benchmark-eval
##===========================================================================

##===========================================================================
## Load Libraries
##===========================================================================

library(reshape2)
library(ggplot2)
library(here)
#contains color blind pallette
# library(RColorBrewer)
library(tidyverse)
# 
# #to view paletts in RColorBrewer pkg
# par(mar=c(3,4,2,2))
# display.brewer.all()

#### suggestion from Nate regarding use of shapes
# If you want to get fancy I like using shapes with outlines, this makes the 
# points pop out more. You would want to use shape 21 for SNP and 25 for INDEL, 
# http://sape.inf.usi.ch/quick-reference/ggplot2/shape, then fill instead of 
# color in the geom_point. You will need to use a custom shape scale. 

##===========================================================================
## Read in data
##===========================================================================

# DF with all metrics
benchComps_strats <- read_csv(
    here("data", "HG002-GRCh38-masking-comparison-stratifications.csv"),
    col_types = cols()
  ) %>% select(Callset, Reference, Genome, benchmark, masking, Subset,
               INDEL.TRUTH.FN, SNP.TRUTH.FN, 
               INDEL.QUERY.FP, SNP.QUERY.FP,  
               INDEL.TRUTH.TP, SNP.TRUTH.TP)

##===========================================================================
## Plot for v0.03.00 -- included in manuscript figure"                      
## "Improvements after masking false duplications" (d)                      
##===========================================================================

#subset to v0.03.00, we only want falsely duplicated strat for the MRG benchmark
benchComps_strats_mrg <- benchComps_strats %>%  
  filter(benchmark == "v0.03.00",
         Subset == "GRCh38_MRG_benchmark_gene_coordinates_falselyduplicated.bed.gz")

meltybench_mrg <- melt(benchComps_strats_mrg)

meltybench_mrg$variable_f = factor(meltybench_mrg$variable, 
                                        levels= c("SNP.TRUTH.FN", 
                                                  "SNP.QUERY.FP", 
                                                  "SNP.TRUTH.TP",
                                                  "INDEL.TRUTH.FN", 
                                                  "INDEL.QUERY.FP", 
                                                  "INDEL.TRUTH.TP"))
mrg_false_dups_plt_df <- meltybench_mrg %>% 
  select(-Subset,-Reference, -Genome, -benchmark) %>%
  separate(variable, into = c("var_type", "Metric"), extra = "merge") %>% 
  mutate(masking = factor(masking,level = c("unmasked", "masked")))
  

(mrg_false_dups_fig <- ggplot(mrg_false_dups_plt_df) +
  geom_path(aes(x = masking,
                y = value,
                group = paste(Callset,  var_type)),
            color = "grey") +
  geom_point(aes(x = masking,
                 y = value,
                 fill = Callset,
                 shape = var_type
                 ),
             size = 3) +
  facet_wrap(~ Metric) +
  labs(x = "GRCh38 False Duplication Masking",
       y = "Count",
       shape = "Variant Type") +
    scale_y_log10() + 
  scale_fill_brewer(palette = "Set2") +
  scale_shape_manual(values = c(21,24)) +
guides(fill = guide_legend(override.aes = list(shape = 21))) +
  theme_bw() +
  theme(legend.position = "right", legend.box = "vertical")
)

ggsave(here("figures","fig3_false_dups.png"), 
       mrg_false_dups_fig,
       height = 2, width = 10, dpi = 300)

ggsave(here("figures","fig3_false_dups.pdf"), 
       mrg_false_dups_fig,
       height = 2.5, width = 10, dpi = 300)

##===========================================================================
## Plot for v4.2.1 -- included in manuscript figure: 
## "Supplementary Figure Masking Minimally affects whole genome accuracy"
##===========================================================================


# subset to 4.2.1 data, no TPs used for 4.2.1 since they are inverse of FN, 
# use all stratifications (*)
benchCompsnew_strats_4.2.1 <- benchComps_strats %>%
  filter(benchmark == "v4.2.1",Subset == "*") %>%
  select(-SNP.TRUTH.TP, -INDEL.TRUTH.TP)

meltybench_v4.2.1 <- melt(benchCompsnew_strats_4.2.1)
meltybench_v4.2.1$variable_f = factor(meltybench_v4.2.1$variable, 
                                      levels= c("SNP.TRUTH.FN", 
                                                "INDEL.TRUTH.FN",
                                                "SNP.QUERY.FP", 
                                                "INDEL.QUERY.FP"))



# use previously melted data and widen adding new columns for relative change (RC) 
# and count_change
benchwider_v4.2.1<- meltybench_v4.2.1 %>%
  pivot_wider(names_from = masking, values_from= value) %>%
  mutate(RC = ((unmasked - masked)/unmasked)) %>%
  mutate(count_change = unmasked - masked)



# Plot count change (unmasked - masked), Facet by variabe, color by callset and 
# xaxis = Type 
ggplot(data=benchwider_v4.2.1, aes(x=variable_f, y=count_change, 
                                   fill="count_change")) + 
  geom_point(size=3, aes(colour = Callset)) +
  labs(x="Type", y="Count Change (unmasked - masked)", 
       title="Count Change for SmVar v4.2.1") +
  guides(fill=FALSE) +
  scale_color_brewer(palette = "Set2") +
  theme_bw() +
  theme(legend.position="bottom") 
#use with theme to make xaxis vertical axis.text.x = element_text(angle = 90)



