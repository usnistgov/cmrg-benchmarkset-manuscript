import argparse

parser = argparse.ArgumentParser(description="Remove refcall above filter")
parser.add_argument('--input', metavar="I", type=str, nargs="+", help="input file")
parser.add_argument('--output_vcf', metavar="O", type=str, nargs="+", help="ouput vcf file")

args = parser.parse_args()

f = open(args.input[0], "r") # need to take in path as argument but developing on single file currently
f_lines = f.readlines()
f_out_vcf = open(args.output_vcf[0], "w+")

for line in f_lines:
    if "#" in line:
        f_out_vcf.write(line)
        f_out_vcf.flush()
        continue
    line_split = line.split("\t")
    chrom = line_split[0]
    position = line_split[1]
    ref = line_split[3]
    alt = line_split[4]
    if "," not in alt:
        if abs(len(ref) - len(alt)) > 34 and abs(len(ref) - len(alt)) < 50:
            f_out_vcf.write(line)
            f_out_vcf.flush()
    else:
        alt_split = alt.split(",")
        alt_split_first_len = len(alt_split[0])
        alt_split_second_len = len(alt_split[1])
        alt_split_min_len = alt_split_first_len if alt_split_first_len < alt_split_second_len else alt_split_second_len
        if abs(len(ref) - alt_split_min_len) > 34 and abs(len(ref) - alt_split_min_len) < 50:
            f_out_vcf.write(line)
            f_out_vcf.flush()

f_out_vcf.close()
