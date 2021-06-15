# CMRG Manuscript Snakemake Pipeline
A Snakemake, https://snakemake.github.io/, pipeline was develope for calculating metrics for manuscript figures, for improved transparency and reproducibility. 
Pipeline output files summarized and converted to tidy data frames for figure generation with `analysis/00_tidying_data.Rmd`.

__Metrics Calculated__
- bases and variants included in medically relevant genes for the different benchmarks
- overlap of medically relevant genes with difficult genomic regions stratifications
- number of variants and variant sizes for medically relevant gene and exon


## Pipeline Inputs
__Genome Files__
- documented in `resources/README.md`

__Benchmark Sets__
- V4.2.1 small variant benchmark sets and V0.6 structural variant benchmark set source documented in `resources/README.md`.
- CMRGv1.00, code used to generate benchmark set in `analysis/benchmark_generation`. 

__MRG Gene List Coords__
- Gene lists and coordinates acquisition defined in `data/gene_coords/README.md`

__Stratifications__
- stratification file source documented in `resources/README.md`

## Pipeline Dependencies
Pipeline uses bcftools, https://samtools.github.io/bcftools/bcftools.html, and bedtools, https://bedtools.readthedocs.io/en/latest/index.html, to calculate metrics. 
Software dependencies handeled using conda, , conda environment defined in `workflow/envs/mrgtools.yml`. 
Snakemake wrappers, https://snakemake-wrappers.readthedocs.io/en/stable/, used when available. 
