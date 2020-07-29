# IGV Session Data Description

## Benchmark Set  
- V4.1 benchmark: NIST_v4.1_SmallVariantDraftBenchmark_12182019  

## Assembly  
- hifiasm dipcall bed and variant files generated by comparing the HG002 PacBio CCS 15kb-20kb dataset assembled using hifiasm r253ab.
- hifiasm hap1 and hap2: HG002 assembled using hifiasm r253ab, assembly mapped to GRCh38 using minimap2 as part of the dipcall pipeline  

## Sequence Datasets  
- Illumina: 2 X 150bp 300X coverage aligned using novoalign, ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/NIST_HiSeq_HG002_Homogeneity-10953946/README_NIST_Illumina_pairedend_HG002.txt  
- 10X: Coverage 84.4X and processed using LongRanger V2.2, ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/analysis/10XGenomics_ChromiumGenome_LongRanger2.2_Supernova2.0.1_04122018/GIAB_README.txt
- CCS: PacBio HiFi version 2 chemistry with 4 X 15kb flowcells and 2 X 20 kb flowcells reads ligned using pbmm2 and phased using whatshap and 10X vcf, ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/PacBio_CCS_15kb_20kb_chemistry2/GRCh38/README.txt
- ONT: GIAB ONT minion UL dataset - basecalling using guppy-V3.4.5, aligned using minimap2. phased using whatshap and 10X vcf; ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/Ultralong_OxfordNanopore/guppy-V3.4.5/README_ONT-UL_GIAB_HG002.md 

## Stratifications 
V2.0 stratifications: https://github.com/genome-in-a-bottle/genome-stratifications 

[TODO - JW provide information for the Segdups, Repeats, and Gaps + Odd Regions stratifications]
- Segdups: https://dl.dnanex.us/F/D/X7V2b94pJGxjG5JZbPk074yjVQY2V1y199Z5G5j0/hg38.segdups.bed.gz  
- Repeats: https://dl.dnanex.us/F/D/5G8Y7xf5kPX3P1gJv91B4GqvQj471JF9P1pVp9f5/hg38.repeats.bed.gz  
- Gaps + Odd Regions: https://dl.dnanex.us/F/D/Vgxq5G630XjYGVY86pBZ5F5Z57Xg47kPkJYq82x7/hg38.oddRegions.bed.gz  
- Assembly CNV: GRCh38_HG002_GIABv4.1_CNV_gt2assemblycontigs_ONTCanu_ONTFlye_CCSCanu.bed.gz  
- CCS and ONT CNV: GRCh38_HG002_GIABv4.1_CNV_CCSandONT_elliptical_outlier.bed.gz  
- mrcanavar CNVs: GRCh38_HG002_GIABv4.1_CNV_mrcanavarIllumina_CCShighcov_ONThighcov_intersection.bed.gz  
- SegDups: GRCh38_gt5segdups_gt10kb_gt99percidentity.bed.gz  
- TandemRepeats >10kb: GRCh38_AllTandemRepeats_gt10000bp_slop5.bed.gz  
- Expanded V0.6 SVs: GRCh38_HG002_expanded_150__Tier1plusTier2_v0.6.1.bed.gz  
- Inversions: GRCh38_HG002_GIABv4.1_inversions_slop25percent.bed.gz  
- VDJ: GRCh38_VDJ.bed.gz  


## Notes
- Additional bams  
    - CCS
        - duplomap: ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/PacBio_CCS_15kb_20kb_chemistry2/GRCh38/
        