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
