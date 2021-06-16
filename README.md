# Genome In A Bottle Challenging Medically Relevant Genes Benchmark 

This repository contains the code used to generate the figures and tables for Wagner et al. 

_Towards a Comprehensive Variation Benchmark for Challenging Medically-Relevant Autosomal Genes_ bioRxiv 2021.06.07.444885; doi: https://doi.org/10.1101/2021.06.07.444885

This analysis uses snakemake to preprocess input data for improved reproducibility and transparency and Rmarkdown files for manuscript figures and results.

## Reproducing figures
The preprocessed figure input data files are included in this repository under `data/tidy`. 
To recreate the preprocessed data you will need to;

1. download files in the `resource` directory (see `resource/README.md` for file source),
1. run snakemake pipeline in the `workflow` directory, 
1. regenerate figure input data files using `analysis/00_tidying_data.Rmd`, then
1. run individual scripts in `analysis` to create individual figure and tables. 

Some figures were generate by manually modifying svg files exported from IGV. 
For transparency the IGV session files are included in `analysis`.


## Repo Structure
Main repository directories include `README.md` files documenting code, data, or image files found in the directory.

```
.
├── analysis - code used to generate figures and tables
├── data - input data for figure code
├── data-raw - data from external analysis not documented in this repository
├── figures - figure image files
├── resources - input data file downloaded from external sources
├── scratch - work in progress analyses
└── workflow - snakemake pipeline home
``