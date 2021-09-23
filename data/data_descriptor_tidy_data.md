# Tidy Data Descriptors

## asm_coverage.tsv.gz
hifiasm diploid assembly coverage of medically relevant genes

- giab_id: GIAB sample id; character string
- gene: Gene name; character string
- ref: reference genome - either GRCh37 or GRCh38; character string
- start: gene start position; integer
- end: gene end position; integer
- region: gene region - gene, exon, intron, or gene-plus-flank; character string
- n_contigs: number of assembled contigs align to the gene; integer
- bp_cov: number of base pairs covered; integer
- region_size: number of base pairs in the genomic region; integer
- overlap: overlap fraction - value between 1 and 0; double

## bench_coverage.tsv.gz
Number of bases and fraction of medically relevant genes by gene region included in GIAB benchmarks.

- gene: Gene name; character string
- ref: reference genome - either GRCh37 or GRCh38; character string
- coords: gene coordinates - `CHROM:START-END`; character string
- benchmark: benchmark set name - V4.2.1, V0.6, or CMRGv1.00; character string
- bench_type: smallvar, SV, or union (combined small variant and SV); character string
- region: gene region - gene, exon, intron, or gene-plus-flank; character string
- cov: coverage fraction - value between 1 and 0; double
- bp_cov: number of base pairs covered; integer
- in_mrg: whether the gene is in the CMRG benchmarkset; logical

## bench_diff_bases.tsv.gz
Coverage of GIAB benchmarks by difficult genomic context stratifications.

- gene: Gene name; character string
- ref: reference genome - either GRCh37 or GRCh38; character string
- coords: gene coordinates - `CHROM:START-END`; character string
- benchmark: benchmark set name - V4.2.1, V0.6, or CMRGv1.00; character string
- bench_type: smallvar, SV, or union (combined small variant and SV); character string
- region: gene region - exon, intron, or gene; character string
- cov: coverage fraction - value between 1 and 0; double
- bp_cov: number of base pairs covered; integer


## gene_list_info.tsv.gz
See `data/README.md` for gene list descriptions

- gene: Gene name, character string
- mandelker: yes/no indicator that the gene is in the Mandelker et al. gene list. 
- cosmic: yes/no indicator that the gene is in the Cosmic gene list.
- high_priority: yes/no indicator that the gene is in the Cosmic gene list.
- ClinGen: number of diagnostic tests/ variants of interest per gene; integer
- CIPC: number of diagnostic tests/ variants of interest per gene; integer
- Counsyl: number of diagnostic tests/ variants of interest per gene; integer
- ACMG: number of diagnostic tests/ variants of interest per gene; integer
- HTD: number of diagnostic tests/ variants of interest per gene; integer
- NCCN: number of diagnostic tests/ variants of interest per gene; integer
- ACOG: number of diagnostic tests/ variants of interest per gene; integer 

## manual_curation.tsv
Reformatted manual curation results for figure generation.

- callset: name of call set (query) being compared to benchmark set (truth); character string
- ref: reference genome - either GRCh37 or GRCh38; character string
- var_type: type of variant curated - SNP or INDEL 
- chrwithprefix: variant chromosome position; character string
- GRCh37_POS: variant base position for GRCh37; integer
- GRCh38_POS: variant base position for GRCh38; integer
- fp_or_fn: whether variant call is a FP, FN, or FP_FN for callset when compared to query
- truth_gt: benchmark set GT at position reported by happy; character string 
- query_gt: callset GT at position reported by happy; character string 
- ref_base: reference base at position; character string 
- alt_base: alternate base at position; character string
- benchmark_correct: curation notes as to whether the benchmark is correct - yes, no, or unsure; character string
- query_correct: curation notes as to whether the benchmark is correct - yes, no, or unsure; character string

## strat_overlap.tsv.gz
Medically relevant genes overlap for difficult genomic context stratifications.

- strat: genomic stratification; character string
- ref: reference genome - either GRCh37 or GRCh38; character string
- region: gene region - gene, exon, intron, or gene-plus-flank; character string
- chrom: gene position chromosom; character string
- start: gene start position; integer
- end: gene end position; integer
- gene: Gene name, character string
- n_regions: Number of stratification regions overlapping gene; integer
- bp_cov: number of base pairs covered; integer
- region_size: number of base pairs in the genomic region; integer
- overlap: overlap fraction - value between 1 and 0; double

## var_tbl.tsv.gz
Table with benchmark variant sizes, positions, along with gene and exon annotations.


- giab_id: sample identifier for GIAB sample; character string
- ref: reference genome - either GRCh37 or GRCh38; character string
- benchmark: benchmark set name - V4.2.1, V0.6, or CMRGv1.00; character string
- bench_type: smallvar, SV, or union (combined small variant and SV); character string
- CHROM: variant chromosome position; character string
- POS: variant base position; integer
- GT: variant genotype; character string
- TYPE: variant type assigned by `bcftools query` - "INDEL", "SNP", "SNP,OVERLAP", "SNP,INDEL", "INDEL,OVERLAP", "OTHER", "SNP", "OTHER"; character string
- GENE: Gene name, character string
- EXON: Ensmble exon id, character string 
- var_size: variant size in bp; integer
- REPTYPE: annotation defined by SVanalyzer's svwiden, Type of SV, with designation of uniqueness of new or deleted sequence - value definitions below (only for SVs); character string
    - SIMPLEDEL=Deletion of at least some unique sequence  
    - SIMPLEINS=Insertion of at least some unique sequence  
    - CONTRAC=Contraction, or deletion of sequence entirely similar to remaining sequence  
    - DUP=Duplication, or insertion of sequence entirely similar to pre-existing sequence  
    - INV=Inversion  
    - SUBSINS=Insertion of new sequence with alteration of some pre-existing sequence  
    - SUBSDEL=Deletion of sequence with alteration of some remaining sequence  
- BREAKSIMLENGTH:  annotation defined by SVanalyzer's svwiden, Length of alignable similarity at event breakpoints as determined by the aligner (only for SVs); integer