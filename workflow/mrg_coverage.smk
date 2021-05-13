### Next Steps
## Work out input file naming conventions - making symbolic links
## Add strat coverage
## Add var table count methods


from snakemake.utils import min_version

### set minimum snakemake version
min_version("5.27.4")

## Loading config file and sample sheet
# configfile: "config/config.yaml"

## Variables for data paths
benchdir = "data/benchmarksets/HG002"

## Defining Wildcards
REFS = ["GRCh37","GRCh38"]
REGIONS = ["gene","exon","intron"]
BENCHTYPES = ["smallvar","SV", "union"]
BENCHSETS = ["v4", "mrg"]

wildcard_constraints:
    ref="|".join(REFS),
    region="|".join(REGIONS),
    benchset="|".join(BENCHSETS),
    benchtype="|".join(BENCHTYPES)

## Define target files for pipeline
rule all:
    input:
        expand(benchdir + "/{ref}/HG002_{ref}_mrg_union.bed", 
                ref = REFS),
        expand("data/gene_stat_tbls/cov_tbls/HG002_{ref}_mrg_{benchtype}_{region}_cov.tsv", 
                ref = REFS, region = REGIONS, benchtype = BENCHTYPES),
        expand("data/gene_stat_tbls/cov_tbls/HG002_{ref}_v4_smallvar_{region}_cov.tsv", 
                ref = REFS, region = REGIONS)#,
        # expand("data/gene_stat_tbls/cov_inputs/allDiff_{ref}_mrg_{region}_cov.tsv", 
        #         ref = REFS, region = REGIONS)




################################################################################
## Combined SM and SV bed file
################################################################################

rule make_union_bed: 
    input:
        sm = benchdir + "/{ref}/HG002_{ref}_mrg_smallvar.bed",
        sv = benchdir + "/{ref}/HG002_{ref}_mrg_SV.bed"
    output: benchdir + "/{ref}/HG002_{ref}_mrg_union.bed"
    conda: "envs/bedtools.yml"
    shell: """
        multiintersectbed \
            -i {input.sm} {input.sv} \
            | sortBed -i stdin \
            | mergeBed \
            -i stdin > {output}
    """

################################################################################
## Intron Region Bed 
################################################################################

rule make_intron_bed: 
    input: 
        exon = "data/mrg_lists/ENSEMBL_coordinates/{ref}_mrg_full_exon.bed",
        gene = "data/mrg_lists/ENSEMBL_coordinates/{ref}_mrg_full_gene.bed"
    output: "data/mrg_lists/ENSEMBL_coordinates/{ref}_mrg_full_intron.bed"
    conda: "envs/bedtools.yml"
    shell: """
        subtractBed \
            -a {input.gene} -b {input.exon} \
            > {output}
    """


################################################################################
## Calculate Included Bases
################################################################################

## Using symbolic links for consistent benchmark region files
rule calc_gene_coverage:
    input:
        a="data/mrg_lists/ENSEMBL_coordinates/{ref}_mrg_full_{region}.bed",
        b=benchdir + "/{ref}/HG002_{ref}_{benchmarkset}_{benchtype}.bed"
    output: "data/gene_stat_tbls/cov_tbls/HG002_{ref}_{benchmarkset}_{benchtype}_{region}_cov.tsv"
    threads: 2
    wrapper: "0.74.0/bio/bedtools/coveragebed"


# rule calc_strat_coverage:
#     input:
#         a=TODO - replace with all difficult strat,
#         b="data/mrg_lists/ENSEMBL_coordinates/{ref}_Medical_Gene_{region}.bed"
#     output: "data/gene_stat_tbls/cov_inputs/allDiff_{ref}_mrg_{region}_cov.tsv"
#     threads: 2
#     wrapper: "0.74.0/bio/bedtools/coveragebed"
