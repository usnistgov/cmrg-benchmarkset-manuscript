# Generate gene lists with overlapping segmental duplications

## GRCh37
```
bedtools slop -i GRCh37_mrg_full_gene.bed -g human.b37.genome -b 20000 > GRCh37_mrg_full_gene_slop20000bp.bed 

python find_flanking_and_segdups_coverage_GRCh37.py --input_genes GRCh37_mrg_full_gene_slop20000bp.bed --output GRCh37_mrg_full_gene-plus-flank.bed 
```

## GRCh38
```
bedtools slop -i GRCh38_mrg_full_gene.bed -g human.hg38.genome -b 20000 > GRCh38_mrg_full_gene_slop20000bp.bed 

python find_flanking_and_segdups_coverage_GRCh38.py --input_genes GRCh38_mrg_full_gene_slop20000bp.bed --output GRCh38_mrg_full_gene-plus-flank.bed 
```