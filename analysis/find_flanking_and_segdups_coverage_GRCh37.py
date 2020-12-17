import argparse
import subprocess

parser = argparse.ArgumentParser(description="Subset bed file to callable regions only")
parser.add_argument('--input_genes', metavar="I", type=str, nargs="+", help="input bed file")
parser.add_argument('--output', metavar="O", type=str, nargs="+", help="output file")
args = parser.parse_args()


f_input_genes = open(args.input_genes[0], "r")
f_input_genes_lines = f_input_genes.readlines()
f_out = open(args.output[0], "w+")

bases_covered_per_gene = []

for gene in f_input_genes_lines:
    #gene = gene.strip("\n")
    gene_name = gene.split("\t")[3].strip("\n")
    print(gene)
    tmf = open("temp_gene_file_" + gene_name + ".bed", "w")
    tmf.write(gene)
    tmf.flush()
    tmf.close()
    subprocess.check_output("bedtools intersect -a GRCh37_segdups.bed.gz -b temp_gene_file_" + gene_name + ".bed -wa | multiIntersectBed -i stdin temp_gene_file_" + gene_name + ".bed | sort -k1,1 -k2,2n | bedtools merge -i stdin > temp_gene_file_" + gene_name + "_with_flanking_sequence_segdups.bed", shell = True)
    subprocess.check_output("cat temp_gene_file_" + gene_name + "_with_flanking_sequence_segdups.bed >> " + args.output[0], shell = True)
    subprocess.check_output("rm temp_gene_file_" + gene_name + ".bed", shell = True)
    subprocess.check_output("rm temp_gene_file_" + gene_name + "_with_flanking_sequence_segdups.bed", shell = True)
