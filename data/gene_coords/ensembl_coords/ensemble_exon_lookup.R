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

