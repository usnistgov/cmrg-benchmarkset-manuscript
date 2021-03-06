# Generate gene lists with overlapping segmental duplications

## GRCh37_Ensembl_exons.tsv and GRCh38_Ensembl_exons.tsv

```
library(biomaRt)
library(tidyverse)
library(here)

grch38_mart <- useEnsembl(biomart = "ensembl", 
				   dataset = "hsapiens_gene_ensembl", 
				   version = "100")


getAtt <- c('chromosome_name', 'exon_chrom_start','exon_chrom_end', 'external_gene_name', 'ensembl_gene_id', 'ensembl_exon_id')
mandelker_genes <- read_tsv(here("data", "mrg_lists", "Mandelker_Medically_Relevant_Genes.tsv"), col_types = "c")
cosmic_genes <- read_tsv(here("data", "mrg_lists", "COSMIC_Gene_Census.tsv"), col_types = "c")
steve_lincoln_compiled_genes <- read_tsv(here("data", "mrg_lists", "Steve_Lincoln_Compiled_Medical_Gene_List.tsv"), col_types = "c")
medical_genes_union <- union(steve_lincoln_compiled_genes$Gene, union(mandelker_genes$Gene, cosmic_genes$Gene))
elocs <- getBM(attributes=getAtt,filters=c("hgnc_symbol","with_ccds"),value=list(medical_genes_union,TRUE),mart=grch38_mart)
exons_grch38_chr1_22 <- elocs %>% filter(chromosome_name %in% paste0("", 1:22))
write_tsv(exons_grch38_chr1_22, "GRCh38_exons.tsv")


grch37_mart <- useEnsembl(biomart = "ensembl", 
						  dataset = "hsapiens_gene_ensembl", 
						  version = "101",
						  GRCh = "37")

grch37_elocs <- getBM(attributes=getAtt,filters=c("hgnc_symbol","with_ccds"),value=list(medical_genes_union,TRUE),mart=grch37_mart)
exons_grch37_chr1_22 <- grch37_elocs %>% filter(chromosome_name %in% paste0("", 1:22))
write_tsv(exons_grch37_chr1_22, "GRCh37_exons.tsv")
```


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


## Medically Relevant Gene Coordinates

### data/gene_coords/unsorted/{GRCh37,GRCh38}_mrg_full_gene.bed
```
The coordinates of the union of genes from (/data/mrg_lists/Steve_Lincoln_Compiled_Medical_Gene_List.tsv, /data/mrg_lists/Steve_Lincoln_Compiled_Medical_Gene_List.tsv, /data/mrg_lists/Steve_Lincoln_Compiled_Medical_Gene_List.tsv) were selected from GRCh38_Ensembl_100_biomart_export.tsv and GRCh37_Ensembl_101_biomart_export.tsv

These then had the gene symbols with duplicated coordinates removed according to "selected_coordinates_for_duplicated_gene_symbol_entries.tsv"
```


### data/gene_coords/unsorted/{GRCh37,GRCh38}_mrg_full_exon.bed
```
The coordinates of the union of genes from (/data/mrg_lists/Steve_Lincoln_Compiled_Medical_Gene_List.tsv, /data/mrg_lists/Steve_Lincoln_Compiled_Medical_Gene_List.tsv, /data/mrg_lists/Steve_Lincoln_Compiled_Medical_Gene_List.tsv) were selected from GRCh38_Ensembl_exons.tsv and GRCh37_Ensembl_exons.tsv

These then had the gene symbols with duplicated coordinates removed according to "selected_coordinates_for_duplicated_gene_symbol_entries.tsv"
```