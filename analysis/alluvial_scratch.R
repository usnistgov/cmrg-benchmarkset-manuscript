library(ggalluvial)
library(sessioninfo)
`%ni%` <- Negate(`%in%`)

ggplot(as.data.frame(Titanic),
	   aes(y = Freq,
	   	axis1 = Survived, axis2 = Sex, axis3 = Class)) +
	geom_alluvium(aes(fill = Class),
				  width = 0, knot.pos = 0, reverse = FALSE) +
	guides(fill = FALSE) +
	geom_stratum(width = 1/8, reverse = FALSE) +
	geom_text(stat = "stratum", aes(label = after_stat(stratum)),
			  reverse = FALSE) +
	scale_x_continuous(breaks = 1:3, labels = c("Survived", "Sex", "Class")) +
	coord_flip() +
	ggtitle("Titanic survival by class and sex")

# Load overlap for HG002 GRCh38 hifiasm v0.11 and v4.2.1 of medically relevant gene coordinates
hifiasm_v11_and_v421_overlap_df_grch38 <- read_tsv("GRCh38_overlap_v4.2.1_hifiasm.tsv", col_types = "cddcddddd")

# Find genes that are less than 90% overlap by v4.2.1 but fully covered including flanking and segdups by hifiasm v11
hifiasm_v11_and_v421_overlap_df_grch38_mutated <- hifiasm_v11_and_v421_overlap_df_grch38 %>% 
		mutate(overlap_v4 = ifelse(percent_overlap_v4.2.1 < .9 & flanking_breaks_in_dip_bed == 0, "overlap_lt_90_v4",
									  	     "overlap_gte_90_v4"))

hifiasm_v11_and_v421_overlap_df_grch38_mutated2 <- hifiasm_v11_and_v421_overlap_df_grch38_mutated %>% 
	mutate(asm_resolved = ifelse(percent_flanking_plus_segdups_overlap_hifiasm < .9, "fully_resolved_asm",
							   "not_resolved_asm"))

hifiasm_v11_and_v421_overlap_df_grch38_mutated3 <- hifiasm_v11_and_v421_overlap_df_grch38_mutated2 %>% 
	mutate(benchmark_membership = ifelse(gene %in% union_GRCh37_GRCh38_MRG_candidates_v421_df, "in_benchmark",
								 "not_in_benchmark"))	

mandelker_list <- read_tsv("Mandelker_Medically_Relevant_Genes.tsv", col_types = "c")
cosmic_list <- read_tsv("COSMIC_Gene_Census.tsv", col_types = "c")
lincoln_list <- read_tsv("Steve_Lincoln_Compiled_Medical_Gene_List.tsv", col_types = "c")

hifiasm_v11_and_v421_overlap_df_grch38_mutated4 <- hifiasm_v11_and_v421_overlap_df_grch38_mutated3 %>% 
	mutate(mandelker_membership = ifelse(gene %in% mandelker_list$Gene, "in_mandelker",
										 "not_in_mandelker"))	

hifiasm_v11_and_v421_overlap_df_grch38_mutated5 <- hifiasm_v11_and_v421_overlap_df_grch38_mutated4 %>% 
	mutate(cosmic_membership = ifelse(gene %in% cosmic_list$Gene, "in_cosmic",
										 "not_in_cosmic"))	

hifiasm_v11_and_v421_overlap_df_grch38_mutated6 <- hifiasm_v11_and_v421_overlap_df_grch38_mutated5 %>% 
	mutate(lincoln_membership = ifelse(gene %in% lincoln_list$Gene, "in_lincoln",
										 "not_in_lincoln"))	
	
hifiasm_v11_and_v421_overlap_df_grch38_mutated_final <- hifiasm_v11_and_v421_overlap_df_grch38_mutated6[,c("gene","overlap_v4", "asm_resolved", "benchmark_membership", "mandelker_membership", "cosmic_membership", "lincoln_membership")]

ggplot(as.data.frame(hifiasm_v11_and_v421_overlap_df_grch38_mutated_final),
	   aes(y = gene,
	   	axis1 = mandelker_membership, axis2 = cosmic_membership, axis3 = lincoln_membership, axis4 = overlap_v4, axis5 = asm_resolved, axis6 = benchmark_membership)) +
	geom_alluvium(width = 0, knot.pos = 0, reverse = FALSE) +
	guides(fill = FALSE) +
	geom_stratum(width = 1/8, reverse = FALSE) +
	geom_text(stat = "stratum", aes(label = after_stat(stratum)),
			  reverse = FALSE) +
	scale_x_continuous(breaks = 1:6, labels = c("mandelker_membership", "cosmic_membership", "lincoln_membership", "overlap_v4", "asm_resolved", "benchmark_membership")) +
	coord_flip() +
	ggtitle("Benchmark generation process Medical Database Membership along with Overlap with v4.2.1 and hifiasm v0.11")

data(majors)
majors$curriculum <- as.factor(majors$curriculum)
ggplot(majors,
	   aes(x = semester, stratum = curriculum, alluvium = student,
	   	fill = curriculum, label = curriculum)) +
	scale_fill_brewer(type = "qual", palette = "Set2") +
	geom_flow(stat = "alluvium", lode.guidance = "frontback",
			  color = "darkgray") +
	geom_stratum() +
	theme(legend.position = "bottom") +
	ggtitle("student curricula across several semesters")

union_GRCh37_GRCh38_MRG_candidates_v421_df <- union(hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch37$gene, hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch38$gene)


union_MRG_df_grch38 <- hifiasm_v11_and_v421_overlap_df_grch38 %>% 
	filter(chrom %in% paste0("chr", 1:22),
		   gene %in% union_GRCh37_GRCh38_MRG_candidates_v421_df,
		   percent_flanking_plus_segdups_overlap_hifiasm == 1,
		   flanking_breaks_in_dip_bed == 0)



# Write bed to file
write_tsv(union_MRG_df_grch37[,1:4], "HG002_GRCh37_Union_MRG.bed", col_names = FALSE)

# Write bed to file
write_tsv(union_MRG_df_grch38[,1:4], "HG002_GRCh38_Union_MRG.bed", col_names = FALSE)

# Genes that are not in ENSEMBL GRCh37
union_GRCh37_GRCh38_MRG_candidates_v421_df[which(union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% hifiasm_v11_and_v421_overlap_df_grch37$gene)]
# "NAPRT"

# Genes that are not in ENSEMBL GRCh38
union_GRCh37_GRCh38_MRG_candidates_v421_df[which(union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% hifiasm_v11_and_v421_overlap_df_grch38$gene)]
# "HEATR2" "TMEM5"  "DYX1C1" "TMEM8A" "CIRH1A"


intersect(union_MRG_df_grch37$gene, union_MRG_df_grch38$gene)

length(intersect(union_MRG_df_grch37$gene, union_MRG_df_grch38$gene))


# In GRCh37 benchmark not in GRCh38
in_GRCh37_not_in_GRCh38 <- union_GRCh37_GRCh38_MRG_candidates_v421_df[union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% union_MRG_df_grch38$gene]
# "HEATR2"  "DLGAP2"  "TMEM5"   "DYX1C1"  "TMEM8A"  "SLC5A11" "CIRH1A"  "KIR2DL3" "KIR2DL1" "ASIP"

# In GRCh38 benchmark not in GRCh37
in_GRCh38_not_in_GRCh37 <- union_GRCh37_GRCh38_MRG_candidates_v421_df[union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% union_MRG_df_grch37$gene]
# "NUTM2D"  "SIRT3"   "C1R"     "TAS2R46" "TMEM114" "INSR"    "INPP5D"  "LRPAP1"  "FAM20C"  "NAPRT"
