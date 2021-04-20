import argparse

parser = argparse.ArgumentParser(description="Separate vcf file into SNPs and INDELs")
parser.add_argument('--input', metavar="I", type=str, nargs="+", help="input threshold file")
parser.add_argument('--output', metavar="S", type=str, nargs="+", help="output threshold file")
args = parser.parse_args()

f = open(args.input[0], "r")
f_lines = f.readlines()

f_out = open(args.output[0], "w+")

for line in f_lines:
    if "#" in line:
        f_out.write(line)
        f_out.flush()
        continue     
    line_split = line.split("\t")
    start = int(line_split[1])
    end = int(line_split[2])
    gene_length = end - start
    coverage_1x = int(line_split[4])
    coverage_10x = int(line_split[5])
    coverage_20x = int(line_split[6])
    coverage_30x = int(line_split[7])
    coverage_40x = int(line_split[8])
    coverage_50x = int(line_split[9])
    coverage_60x = int(line_split[10])
    coverage_70x = int(line_split[11])
    coverage_80x = int(line_split[12])
    coverage_90x = int(line_split[13])
    coverage_100x = int(line_split[14])
    coverage_1x_percentage = float(coverage_1x)/float(gene_length)
    coverage_10x_percentage = float(coverage_10x)/float(gene_length)
    coverage_20x_percentage = float(coverage_20x)/float(gene_length)
    coverage_30x_percentage = float(coverage_30x)/float(gene_length)
    coverage_40x_percentage = float(coverage_40x)/float(gene_length)
    coverage_50x_percentage = float(coverage_50x)/float(gene_length)
    coverage_60x_percentage = float(coverage_60x)/float(gene_length)
    coverage_70x_percentage = float(coverage_70x)/float(gene_length)
    coverage_80x_percentage = float(coverage_80x)/float(gene_length)
    coverage_90x_percentage = float(coverage_90x)/float(gene_length)
    coverage_100x_percentage = float(coverage_100x)/float(gene_length)
    to_write_out = line_split[0] + "\t" + line_split[1] + "\t" + line_split[2] + "\t" + line_split[3] + "\t" + str(coverage_1x_percentage) + "\t" + str(coverage_10x_percentage) + "\t" + str(coverage_20x_percentage) + "\t" + str(coverage_30x_percentage) + "\t" + str(coverage_40x_percentage) + "\t" + str(coverage_50x_percentage) + "\t" + str(coverage_60x_percentage) + "\t" + str(coverage_70x_percentage) + "\t" + str(coverage_80x_percentage) + "\t" + str(coverage_90x_percentage) + "\t" + str(coverage_100x_percentage) + "\n"
    f_out.write(to_write_out)
    f_out.flush()  

f_out.close()
f.close()