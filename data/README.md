# Data files
<!-- File use description
- primary analysis output used in secondary analysis
- mature datasets released with publication should have accompanying README files and data descriptor files as appropraite.
- Use subfolders for multifile datasets when appropriate and it facilitates documentation
-->

- file: HG002-GRCh38-masking-comparison-stratifications.csv
    - description: 
    - md5: edb2865d6e7c75e95b6d201d87de5767


Data file documentation split by subdirectory

## Benchmark Evaluations

- file: benchmark_evaluation/combined curation responses from benchmarking with sm variant v0.02.03.xlsx
    - url: https://docs.google.com/spreadsheets/d/1Pn7WP78JfWKCO2Df31n_4gzDOwtP69flgDyyjeBS6JE/edit?usp=sharing
    - md5: 02b214c213cdcbb45b431037030d177
    - access: exported as excel from google sheets on 4/19/21  

- file: benchmark_evaluation/smvar HG002 MRG v0.03.00 evaluation.xlsx 
    - url: https://docs.google.com/spreadsheets/d/1smJ-ATsXwko2sCOTh4Lcyi8msnx1FM1zkERacQdHYY0/edit#gid=417145618
    - md5: c0fe238d36fcf488633b531bc170a18d
    - access: exported as excel file from googlesheet on 5/18/21 

- file: dataset_names.tsv
    - source: manually generated
    - md5: ddfe08317c9f2e870be476689a1eaef9
    - data description: TSV table with variant callset metadata
        - Columns:
            - sequencing_technology: type of sequencing data used to generate variant callset
            - variant_caller: variant caller used to generate callset
            - mapper_assembler: read mapper or assembler used in variant calling
            - callset_id: short callset id
            - callset: callset name used in figure annotation 


## GRCh38 False Duplications
- file: HG002-GRCh38-masking-comparison-stratifications.csv
    - description: benchmarking performance comparison when masking falsely duplicated genes on chromosome 21 in GRCh38
    - md5: edb2865d6e7c75e95b6d201d87de5767

Variant callset comparisons when using masked GRCh38 and unmasked GRCh38 as reference genome. 
VCFs used in false_dups IGV session file for panel A of the false duplication figure.
md5s in `false/dups/chksum.md5`

- file: false_dups/Baylor_ILMN_GATK/HG002_38_nodecoy.vcf.gz
- file: false_dups/Baylor_ILMN_GATK/HG002_38_nodecoy.vcf.gz.tbi
- file: false_dups/Baylor_ILMN_GATK/HG002_38_nodecoy_mask.vcf.gz
- file: false_dups/Baylor_ILMN_GATK/HG002_38_nodecoy_mask.vcf.gz.tbi
- file: false_dups/Baylor_ILMN_GATK/HG002_38_nodecoy_mask_v2.vcf.gz
- file: false_dups/Baylor_ILMN_GATK/HG002_38_nodecoy_mask_v2.vcf.gz.tbi- file: 
- file: false_dups/ONT-minimap2-clair2/HG002.SNVs.minimap2.clair2.masked.GRCh38.vcf.gz
- file: false_dups/ONT-minimap2-clair2/HG002.SNVs.minimap2.clair2.masked.GRCh38.vcf.gz.tbi
- file: false_dups/ONT-minimap2-clair2/HG002.SNVs.minimap2.clair2.unmasked.GRCh38.vcf.gz
- file: false_dups/ONT-minimap2-clair2/HG002.SNVs.minimap2.clair2.unmasked.GRCh38.vcf.gz.tbi


## Gene Coordinates
Gene coordinates file source documented in `gene_coords/README.md`

## MRG Benchmarkset 
Benchmarkset files from an early version of the bnechmark and dependencies for benchmark generation. 
The benchmark generation files will be moved to a separate repository for the benchmark generation pipeline. 

## Medically Relevant Gene Lists

- file: Steve_Lincoln_Compiled_Medical_Gene_List.tsv 
    - url: https://docs.google.com/spreadsheets/d/1PLfRdIQIRm186frFYNbseCEOzIi5RW-l/edit#gid=61579885
    - accessed: exported as tsv from google sheets on 2020-12-16
    - description: manually currated list of high priority medically relevant from compiled from multiple gene list by Steve Lincoln.

- file: COSMIC_Gene_Census.tsv
	- url: https://cancer.sanger.ac.uk/census
	- accessed: Dec 17, 2020
	
- file: Mandelker_Medically_Relevant_Genes.tsv 
    - url: https://static-content.springer.com/esm/art%3A10.1038%2Fgim.2016.58/MediaObjects/41436_2016_BFgim201658_MOESM14_ESM.zip
    - description: medically relevant genes list from Mandelker et al. ( https://doi.org/10.1038/gim.2016.58) supplemental table 13 Table_S13_Medically_Relevant_Genes.xlsx


## ams_vars_regions
hifiasm variant calls and regions generated using dipcall 
[TODO - add reference genome version info and dipcall run parameters]
[TODO JW? - how were SVsgt49bp_repeatexpander.. files generated]
```
├── GRCh37
│   ├── HG002v11-align2-GRCh37.dip.vcf.gz
│   ├── HG002v11-align2-GRCh37.dip_SVsgt49bp.bed
│   └── HG002v11-align2-GRCh37.dip_SVsgt49bp_repeatexpanded_slop50_merge1000.bed
└── GRCh38
    ├── HG002v11-align2-GRCh38.dip.vcf.gz
    ├── HG002v11-align2-GRCh38.dip_SVsgt49bp.bed
    └── HG002v11-align2-GRCh38.dip_SVsgt49bp_repeatexpanded_slop50_merge1000.bed
```

## mrg_benchmarkset
Benchmark set variants and regions.
GRCh37 and GRCh38 files generated using the appropriate ipython notebook, `analysis/GRCh3{7,8}_HG002_medical_genes_benchmark_generation.ipynb`.

[TODO - document notebook input files and dependencies]
[TODO - document source of files under `Regions_to_exclude_from_small_variant_benchmark` and move to `data-raw` if appropriate.]
[TODO - determine which intermediate files are necessary]
```
├── HG002
│   ├── GRCh37
│   │   ├── HG002_GRCh37_difficult_medical_gene_smallvar_benchmark.bed
│   │   ├── HG002_GRCh37_difficult_medical_gene_smallvar_benchmark.vcf.gz
│   │   ├── HG002_GRCh37_difficult_medical_gene_smallvar_benchmark.vcf.gz.tbi
│   │   ├── intermediate_files
│   │   │   ├── HG002_GRCh37_MRG.bed
│   │   │   ├── HG002_GRCh37_MRG_No_MHC.bed
│   │   │   ├── HG002_GRCh37_MRG_merged.bed
│   │   │   ├── HG002_GRCh37_Union_MRG_No_MHC.bed
│   │   │   ├── HG002_GRCh37_Union_MRG_merged.bed
│   │   │   ├── HG002_GRCh37_Union_MRG_temp_subtract_GRCh37_MRG_GAPs.bed
│   │   │   ├── HG002_GRCh37_Union_MRG_temp_subtract_GRCh37_MRG_GAPs_sorted.bed
│   │   │   ├── HG002_GRCh37_Union_MRG_temp_subtract_GRCh37_SimpleRepeat_homopolymer_gt20_slop5.bed
│   │   │   ├── HG002_GRCh37_Union_MRG_temp_subtract_GRCh37_SimpleRepeat_imperfecthomopolgt20_slop5.bed
│   │   │   ├── HG002_GRCh37_Union_MRG_temp_subtract_SVsgt49bp_repeatexpanded_slop50_merge1000.bed
│   │   │   ├── HG002_GRCh37_Union_MRG_temp_subtract_hifiasm_error.bed
│   │   │   └── HG002_GRCh37_Union_MRG_temp_subtract_partial_tandem_repeats.bed
│   │   └── remapped_HG002_GRCh38_difficult_medical_gene_smallvar_benchmark.bed
│   └── GRCh38
│       ├── HG002_GRCh38_difficult_medical_gene_smallvar_benchmark.bed
│       ├── HG002_GRCh38_difficult_medical_gene_smallvar_benchmark.vcf.gz
│       ├── HG002_GRCh38_difficult_medical_gene_smallvar_benchmark.vcf.gz.tbi
│       └── intermediate_files
│           ├── HG002_GRCh38_MRG.bed
│           ├── HG002_GRCh38_MRG_merged.bed
│           ├── HG002_GRCh38_MRG_no_MHC.bed
│           ├── HG002_GRCh38_Union_MRG_No_MHC.bed
│           ├── HG002_GRCh38_Union_MRG_merged.bed
│           ├── HG002_GRCh38_Union_MRG_temp_subtract_GRCh38_MRG_GAPs.bed
│           ├── HG002_GRCh38_Union_MRG_temp_subtract_GRCh38_MRG_GAPs_sorted.bed
│           ├── HG002_GRCh38_Union_MRG_temp_subtract_GRCh38_SimpleRepeat_homopolymer_gt20_slop5.bed
│           ├── HG002_GRCh38_Union_MRG_temp_subtract_GRCh38_SimpleRepeat_imperfecthomopolgt20_slop5.bed
│           ├── HG002_GRCh38_Union_MRG_temp_subtract_SVsgt49bp_repeatexpanded_slop50_merge1000.bed
│           ├── HG002_GRCh38_Union_MRG_temp_subtract_hifiasm_error.bed
│           └── HG002_GRCh38_Union_MRG_temp_subtract_partial_tandem_repeats.bed
└── Regions_to_exclude_from_small_variant_benchmark
    ├── GRCh37_MRG_GAPs.bed
    ├── GRCh37_SimpleRepeat_homopolymer_gt20.bed.gz
    ├── GRCh37_SimpleRepeat_homopolymer_gt20_slop5.bed.gz
    ├── GRCh37_SimpleRepeat_imperfecthomopolgt20_slop5.bed.gz
    ├── GRCh37_hifiasm_error.bed
    ├── GRCh38_MRG_GAPs.bed
    ├── GRCh38_SimpleRepeat_homopolymer_gt20_slop5.bed.gz
    ├── GRCh38_SimpleRepeat_imperfecthomopolgt20_slop5.bed.gz
    ├── GRCh38_hifiasm_error.bed
    ├── HG002v11-align2-GRCh37.dip_SVsgt49bp_repeatexpanded_slop50_merge1000.bed
    └── HG002v11-align2-GRCh38.dip_SVsgt49bp_repeatexpanded_slop50_merge1000.bed
```
## mrg_lists
List of medically relevant genes

COSMIC_Gene_Census - https://cancer.sanger.ac.uk/census accessed 2020-12-16

Mandelker_Medically_Relevant_Genes.tsv - Supplementary Table 13 - https://www.nature.com/articles/gim201658

[TODO - document gene list source and scripts use to generate files when appropriate]
```
.
├── COSMIC_Gene_Census.tsv
├── Collected\ Guideline\ Genes.xlsx
├── ENSEMBL_coordinates
│   ├── GRCh38_Mandelker_COSMIC_ENSEMBLE_coordinates_primary_assembly.bed
│   └── GRCh38_Mandelker_COSMIC_ENSEMBLE_coordinates_primary_assembly_slop20000.bed
├── Mandelker_Medically_Relevant_Genes.tsv
├── Mandelker_Medically_Relevant_and_COSMIC_unique_gene_symbols.tsv
└── Steve_Lincoln_Compiled_Medical_Gene_List.tsv
```

## Overlap analysis
gene coverage analysis

[TODO - document file generation process, remove redundant and unnecessary files, if any]

GRCh38_overlap_v4.2.1_hifiasm.tsv - overlap between each medical gene and HG002 GRCh38 v4.2.1 and HG002 hifiasm v0.11 generated by steps 1-3 of `analysis/GRCh38_HG002_medical_genes_benchmark_generation.ipynb`

```
.
├── GRCh37
│   ├── GRCh37_overlap_genes_in_37_not_in_38.tsv
│   ├── GRCh37_overlap_genes_in_38_not_in_37.tsv
│   └── GRCh37_overlap_v4.2.1_hifiasm.tsv
└── GRCh38
    ├── GRCh38_overlap_genes_in_37_not_in_38.tsv
    ├── GRCh38_overlap_genes_in_38_not_in_37.tsv
    └── GRCh38_overlap_v4.2.1_hifiasm.tsv
```

## Old Documentation - need to update/ revise
GRCh38_mrg_v4.1_r253_coverage.tsv -- contains medically-relevant genes overlap with the HG002 GRCh38 v4.1 benchmark regions and the r253 HPRC diploid assembly of HG002 as developed in analysis/GRCh38_Analysis.ipynb

Mandelker_Medically_Relevant_and_COSMIC_unique_gene_symbols.tsv -- combined resources/Mandelker_Medically_Relevant_Genes.tsv and resources/COSMIC_Gene_Census.tsv using uniq

HG002r253ab-align2-GRCh38.dip.bed -- dipcall output downloaded from https://drive.google.com/file/d/1lPXuZVrmwFnXd3CUlq1jHAvzeai8UYw0/view?usp=sharing


Collected Guideline Genes.xlsx -- list of genes with clinical relevance, used in clinical testing. Downloaded from https://docs.google.com/spreadsheets/d/1NYBbtgzB5zqpIwbGpftc--BA_gbFNj5ixhf7VZGb6hc/edit?usp=sharing on 8/13/20. Additional relevant material in https://drive.google.com/drive/folders/1gUjMx24CkZCbt4vC46W3nQY_3DcjP4X9. 

benchmark_comparison_mrg.tsv - GATK Ill benchmarking results for draft MRG and V4.2 benchmark set, initial analysis for J. Wagner 2020 ASHG presentation.
