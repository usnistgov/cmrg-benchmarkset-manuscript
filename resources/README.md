# Resources
<!-- File use description
- data files (read-only) obtained from community resource, e.g. human reference genome, or GIAB benchmark set. 
- Include source (e.g. url, doi), accession information (data accessed), and MD5 in this README for reproducibility and transparency.
-->

## Genome Files

__Reference Genome Files__
- file: resources.human.b37.genome
	- url:
	- md5: 7c2448bb45cf051baf2239c35ce1dca2
	- notes: [TODO] Add file source

- file: resources.human.hg38.genome
	- url:
	- md5: 8213a20ea4c51028d282f31fd2f9b48f
	- notes: [TODO] Add file source


__CMRG HG002 Small Variant and Structural Variant Benchmark Set__
see `analysis/benchmark_generation` for code use to generate the files 

- Citation DOI: Wagner et al. 2021 https://doi.org/10.1101/2021.06.07.444885 
- file: resources/NIST_MedicalGene_v1.00.01/HG002_GRCh37_difficult_medical_gene_SV_benchmark_v1.00.01.bed
	- url:
	- md5: decd77f73205cb179cdfc2b3b9ddea8b

- file: resources/NIST_MedicalGene_v1.00.01/HG002_GRCh38_difficult_medical_gene_SV_benchmark_v1.00.01.bed
	- url:
	- md5: f74e814fd017ebd04bd58e1ef6e3a126

- file: resources/NIST_MedicalGene_v1.00.01/HG002_GRCh37_difficult_medical_gene_SV_benchmark_v1.00.01.vcf.gz
	- url:
	- md5: 144fac921b18b1959032273461f28b3e  

- file: resources/NIST_MedicalGene_v1.00.01/HG002_GRCh38_difficult_medical_gene_SV_benchmark_v1.00.01.vcf.gz
	- url:
	- md5: 197110493bfdaf4f92a00d70523cfdd2

- file: resources/NIST_MedicalGene_v1.00.01/HG002_GRCh37_difficult_medical_gene_smallvar_benchmark_v1.00.01.vcf.gz
	- url:
	- md5: a9427c1b6f470237c9b70c205a05b5cc

- file: resources/NIST_MedicalGene_v1.00.01/HG002_GRCh37_difficult_medical_gene_smallvar_benchmark_v1.00.01.bed
	- url:
	- md5: e4d829c66b3a6ad50ab3f00aa78ab050

- file: resources/NIST_MedicalGene_v1.00.01/HG002_GRCh38_difficult_medical_gene_smallvar_benchmark_v1.00.01.vcf.gz
	- url:
	- md5: 1118a6b90f3f72dafa760cc53555f8e6

- file: resources/NIST_MedicalGene_v1.00.01/HG002_GRCh38_difficult_medical_gene_smallvar_benchmark_v1.00.01.bed 
	- url:
	- md5: 9a36e9d67335dc9bb3979d070fac4c9d


__GIAB v4.2.1 HG002 Small Variant Benchmark Set__ 
- Citation DOI: Wagner et al. 2020 https://doi.org/10.1101/2020.07.24.212712 
- file: resources/HG002_GRCh37_1_22_v4.2 1_benchmark.vcf.gz
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/AshkenazimTrio/HG002_NA24385_son/NISTv4.2.1/GRCh37/HG002_GRCh37_1_22_v4.2.1_benchmark.vcf.gz
	- md5: ca24fb3952107f01eecfe1b222a2e66c

- file: resources/HG002_GRCh37_1_22_v4.2.1_benchmark_noinconsistent.bed
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/AshkenazimTrio/HG002_NA24385_son/NISTv4.2.1/GRCh37/HG002_GRCh37_1_22_v4.2.1_benchmark_noinconsistent.bed
	- md5: 03de38ff97f02ed5a021419e69eaaa25

- file: resources/HG002_GRCh38_1_22_v4.2.1_benchmark.vcf.gz
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/AshkenazimTrio/HG002_NA24385_son/NISTv4.2.1/GRCh38/HG002_GRCh38_1_22_v4.2.1_benchmark.vcf.gz
	- md5: dc750b3807d4af1f7ffec852e9c2f771

- file: resources/HG002_GRCh38_1_22_v4.2.1_benchmark_noinconsistent.bed
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/AshkenazimTrio/HG002_NA24385_son/NISTv4.2.1/GRCh38/HG002_GRCh38_1_22_v4.2.1_benchmark_noinconsistent.bed
	- md5: 97265e922a97c69a0391cf3f92a89b8b


__GIAB v0.6 HG002 Structural Variant Benchmark__
- Citation DOI: Zook et al. 2020 https://doi.org/10.1038/s41587-020-0538-8
- file: resources/HG002_Svs_Tier1_v0.6.vcf.gz
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/AshkenazimTrio/HG002_NA24385_son/NIST_SV_v0.6/HG002_SVs_Tier1_v0.6.vcf.gz
	- md5: 78bceed7edda5c4ae373f5e4c31f72cd

- file: resources/HG002_SVs_Tier1_noVDJorXorY_v0.6.2.bed
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/AshkenazimTrio/HG002_NA24385_son/NIST_SV_v0.6/HG002_SVs_Tier1_noVDJorXorY_v0.6.2.bed
	- md5: 1bd7f5f84bc956847790a80db4f073eb

## Stratifications
- Citation DOI: Olson et al. 2021 https://doi.org/10.1101/2020.11.13.380741 
__All Difficult__

- file: GRCh37_HG002_GIABv4.1_complexandSVs_alldifficultregions.bed.gz
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/genome-stratifications/v2.0/GRCh37/GenomeSpecific/GRCh37_HG002_GIABv4.1_complexandSVs_alldifficultregions.bed.gz
	- md5: 4d59751a9d3dcdd7bcefa4c924afbf3b

- file: GRCh38_HG002_GIABv4.1_complexandSVs_alldifficultregions.bed.gz
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/genome-stratifications/v2.0/GRCh38/GenomeSpecific/GRCh38_HG002_GIABv4.1_complexandSVs_alldifficultregions.bed.gz
	- md5: 44be89cbf38b798c046775dca13f9d50


__Segmental Duplications__

- file: GRCh37_segdups.bed.gz
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/genome-stratifications/v2.0/GRCh37/SegmentalDuplications/GRCh37_segdups.bed.gz
	- md5: 383beee3746ecb2e88bcedbdf7614dc6

- file: GRCh38_segdups.bed.gz
	- url: https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/genome-stratifications/v2.0/GRCh38/SegmentalDuplications/GRCh38_segdups.bed.gz`
	- md5: d6d985395c5f730e75e671a4d991743c
