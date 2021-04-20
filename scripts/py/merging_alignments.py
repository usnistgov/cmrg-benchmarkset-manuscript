import argparse

parser = argparse.ArgumentParser(description="Add region size to benchmark bed")
parser.add_argument('--input_table', metavar="I", type=str, nargs="+", help="input table file")
parser.add_argument('--input_alignments', metavar="I", type=str, nargs="+", help="input contig file")
parser.add_argument('--output', metavar="I", type=str, nargs="+", help="output bed file")
args = parser.parse_args()

f_table = open(args.input_table[0], "r") # need to take in path as argument but developing on single file currently
f_contig = open(args.input_contig[0], "r") # need to take in path as argument but developing on single file currently

f_out = open(args.output[0], "w+")

lines_table = f_table.readlines()
lines_contig = f_contig.readlines()

for table_line in lines_table:
    if "#" in table_line:
        continue
    table_line_stripped = table_line.strip()
    num_table_line_hits = 0
    GRCh38 = " "
    seq1_len = " "
    seq2_len = " "
    seq2_len_div_seq1_len = " "
    aln_block_size = " "
    diff = " "
    idt = " "
    same = " "
    err_est2 = " "

    split_line = table_line.split(",")
    table_key = split_line[0]
    for contig_line in lines_contig:
        contig_split_line = contig_line.split(",")
        contig_key = contig_split_line[0]
        if table_key == contig_key:
            if "H1" in contig_split_line[1]:
                h1_length_ratio = contig_split_line[4].strip()
            elif "H2" in contig_split_line[1]:
                h2_length_ratio = contig_split_line[4].strip()
            num_table_line_hits = num_table_line_hits + 1
    to_write_out = table_line_stripped + ", " + h1_length_ratio + ", " + h2_length_ratio + ", " + str(num_table_line_hits) + "\n"
    f_out.write(to_write_out)
    f_out.flush()

f_table.close()
f_contig.close()
f_out.close()