library(tidyverse)
library(ggrepel)
library(ggpubr)
library(here)


## Stratification Annotations
strats <- c(`TR and Homop` = "All Tandem Repeats and Homopolymers",
            All = "*",
            `Not Diff` = "Not In All Difficult Regions",
            SegDups = "Segmental Duplications")

## Benchmarking data
bench_df <- read_tsv(here("data", "benchmark_comparison_mrg.tsv")) %>% 
    mutate(Subset = factor(Subset, levels = strats, labels = names(strats)))


## New scatter plots V4 MRG comparison
wide_bench_df <- bench_df %>% 
    mutate(fn_rate = 1 - Recall) %>% 
    mutate(Version = if_else(Version == "Draft", "MRG", Version)) %>% 
    select(Version, Type, Subset, fn_rate, Frac_NA) %>% 
    pivot_longer(cols = c("fn_rate", "Frac_NA"), names_to = "metrics") %>% 
    pivot_wider(names_from = Version, values_from = value)

wide_bench_df %>% 
    mutate(metrics = if_else(metrics == "fn_rate", "FN Rate", "Frac Not Assessed")) %>% 
    ggplot(aes(x = v4.2, y = MRG)) + 
    geom_abline(aes(intercept = 0, slope = 1), linetype = 2, color = "grey60") + 
    geom_text_repel(aes(label = Subset), size = 2) +
    geom_point(aes(color = Subset, shape = Type)) + 
    facet_wrap(~metrics) + 
    scale_color_brewer(type = "qual", palette = 2) + 
    theme_bw() + 
    theme(legend.position = "bottom", legend.box = "vertical") + 
    labs(x = "V4.2 Benchmark", y = "Draft Med. Relevant Genes", 
         shape = "Variant Type", color = "Stratification")

ggsave("figures/v4_versus_mrg_scatter.pdf", width = 6, height = 4)
