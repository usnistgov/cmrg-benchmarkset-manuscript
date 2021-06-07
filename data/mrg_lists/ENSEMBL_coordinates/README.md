# Generate gene lists with overlapping segmental duplications
[TODO] Add documentation for how ENSEMBL gene and exon coordinate files were obtained.

## GRCh38_Ensembl_100_biomart_export.tsv
```
Original approach through web interface  - last accessed June 4, 2021

http://apr2020.archive.ensembl.org/
Database: Ensembl Genes 100
Dataset: Human genes (GRCh38.p13)
Filters: Chromosome/scaffold: 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , MT , X , Y
Attributes: Gene stable ID	Gene start (bp)	Gene end (bp)	Chromosome/scaffold name	Gene name
Results: check "unique results only" then download tsv
```

## GRCh37_Ensembl_101_biomart_export.tsv 
```
Approach through web interface - last accessed June 4, 2021

http://grch37.ensembl.org/biomart/martview
Database:Ensemble Genes 104 (This does not update for GRCh37 since version 75 so it does not impact 104 vs 101 vs 100)
Dataset: Human genes (GRCh37.p13)
Filters: Chromosome/scaffold: 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , MT , X , Y
Attributes: Gene stable ID	Gene start (bp)	Gene end (bp)	Chromosome/scaffold name	Gene name
Results: check "unique results only" then download tsv
```

selected genes file was manually generated using list of duplicate genes and identifying appropriate gene symbol to exclude

_Note_ Paths and file names are not consistent with current filenames and locations 
## GRCh37
```
bedtools slop \
    -i GRCh37_mrg_full_gene.bed \
    -g human.b37.genome -b 20000 \
    > GRCh37_mrg_full_gene_slop20000bp.bed 

python find_flanking_and_segdups_coverage_GRCh37.py \
    --input_genes GRCh37_mrg_full_gene_slop20000bp.bed \
    --output GRCh37_mrg_full_gene-plus-flank.bed 
```

## GRCh38
```
bedtools slop \
    -i GRCh38_mrg_full_gene.bed \
    -g human.hg38.genome -b 20000 \
    > GRCh38_mrg_full_gene_slop20000bp.bed 

python find_flanking_and_segdups_coverage_GRCh38.py \
    --input_genes GRCh38_mrg_full_gene_slop20000bp.bed \
    --output GRCh38_mrg_full_gene-plus-flank.bed 
```