import argparse
import subprocess

parser = argparse.ArgumentParser(description="Subset bed file to callable regions only")
parser.add_argument('--input_benchmark', metavar="I", type=str, nargs="+", help="input bed file")
parser.add_argument('--input_genes', metavar="I", type=str, nargs="+", help="input bed file")
parser.add_argument('--output', metavar="O", type=str, nargs="+", help="output file")
args = parser.parse_args()

benchmark_filename = args.input_benchmark[0]

f_input_genes = open(args.input_genes[0], "r")
f_input_genes_lines = f_input_genes.readlines()
f_out = open(args.output[0], "w+")

variants_in_gene = []

for gene in f_input_genes_lines:
    gene = gene.strip("\n")
    print(gene)
    tmf = open("temp_gene_file_" + args.output[0], "w")
    tmf.write(gene)
    tmf.flush()
    tmf.close()
   #subprocess.check_output("echo '" + gene + "' > temp_gene_file_" + args.output[0], shell = True)
    variants_covered = subprocess.check_output("bedtools intersect -a temp_gene_file_" + args.output[0] + " -b " + benchmark_filename + " | wc -l ", shell = True).strip()
    if variants_covered != '':
        variants_in_gene.append(variants_covered)
    else:
        variants_in_gene.append('0')
    subprocess.check_output("rm temp_gene_file_" + args.output[0], shell = True)

print(variants_in_gene)
for i in range(0, len(f_input_genes_lines)):
    line = f_input_genes_lines[i]
    if "#" in line:
        f_out.write(line)
        f_out.flush()
        continue     
    line_split = line.split("\t")
    start = int(line_split[1])
    end = int(line_split[2])
    gene_length = end - start
    to_write_out = line_split[0] + "\t" + line_split[1] + "\t" + line_split[2] + "\t" + line_split[3].strip() + "\t" + str(variants_in_gene[i]) + "\n"
    f_out.write(to_write_out)
    f_out.flush()  

f_out.close()
f_input_genes.close()