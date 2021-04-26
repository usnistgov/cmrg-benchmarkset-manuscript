### set minimum snakemake version
# min_version("5.27.4")

## Loading config file and sample sheet
# configfile: "config/config.yaml"

## Variables for data paths
benchdir = "data/mrg_benchmarkset/HG002"

## Defining Wildcards
REFS = ["GRCh37","GRCh38"]
REGIONS = ["gene","exon","flank"]
BENCHSETS = ["smallvar","SV", "union"]

wildcard_constraints:
    ref="|".join(REFS),
    region="|".join(REGIONS),
    benchset="|".join(BENCHSETS)

## Define target files for pipeline
rule all:
    input:
        expand(benchdir + "/{ref}/HG002_{ref}_difficult_medical_gene_union_benchmark_v1.00.00.bed", 
                ref = REFS),
        expand("data/gene_stat_tbls/tbl_inputs/HG002_{ref}_mrg_{benchset}_{region}_cov.tsv", 
                ref = REFS, region = REGIONS, benchset = BENCHSETS)
                

################################################################################
## Combined SM and SV bed file
################################################################################

rule make_union_bed: 
    input:
        sm = benchdir + "/{ref}/HG002_{ref}_difficult_medical_gene_smallvar_benchmark_v1.00.00.bed",
        sv = benchdir + "/{ref}/HG002_{ref}_difficult_medical_gene_SV_benchmark_v1.00.00.bed"
    output: benchdir + "/{ref}/HG002_{ref}_difficult_medical_gene_union_benchmark_v1.00.00.bed"
    conda: "envs/bedtools.yml"
    shell: """
        multiintersectbed \
            -i {input.sm} {input.sv} \
            | sortBed -i stdin \
            | mergeBed \
            -i stdin > {output}
    """

## Get Flanking Beds
# Used symbolic links to standardize file names
rule get_flanks: 
    input: 
        gene = "data/mrg_lists/ENSEMBL_coordinates/{ref}_Medical_Gene_gene-plus-flank.bed",
        gene_plus_flank = "data/mrg_lists/ENSEMBL_coordinates/{ref}_Medical_Gene_gene-plus-flank.bed"
    output: "data/mrg_lists/ENSEMBL_coordinates/{ref}_Medical_Gene_flank.bed"
    conda: "envs/bedtools.yml"
    shell: """
        bedtools subtract -a {input.gene_plus_flank} -b {input.gene} > {output}
    """


## Using symbolic links for consistent benchmark region files
rule calc_coverage:
    input:
        a="data/mrg_lists/ENSEMBL_coordinates/{ref}_Medical_Gene_{region}.bed",
        b=benchdir + "/{ref}/HG002_{ref}_difficult_medical_gene_{benchset}_benchmark_v1.00.00.bed"
    output: "data/gene_stat_tbls/tbl_inputs/HG002_{ref}_mrg_{benchset}_{region}_cov.tsv"
    threads: 2
    wrapper: "0.74.0/bio/bedtools/coveragebed"
