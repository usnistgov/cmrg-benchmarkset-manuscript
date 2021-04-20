import argparse

parser = argparse.ArgumentParser(description="Add region size to benchmark bed")
parser.add_argument('--input_table', metavar="I", type=str, nargs="+", help="input table file")
parser.add_argument('--input_similarity', metavar="I", type=str, nargs="+", help="input contig file")
parser.add_argument('--output', metavar="I", type=str, nargs="+", help="output bed file")
args = parser.parse_args()

f_table = open(args.input_table[0], "r") # need to take in path as argument but developing on single file currently
f_similarity = open(args.input_similarity[0], "r") # need to take in path as argument but developing on single file currently

f_out = open(args.output[0], "w+")

lines_table = f_table.readlines()
lines_similarity = f_similarity.readlines()

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
    split_line = table_line.split("\t")
    table_key = split_line[0]
    for similarity_line in lines_similarity:
        similarity_line_stripped = similarity_line.strip()
        similarity_split_line = similarity_line_stripped.split("\t")
        similarity_key = similarity_split_line[0]
        if table_key == similarity_key:
            GRCh38 = similarity_split_line[1]
            seq1_len = similarity_split_line[2]
            seq2_len = similarity_split_line[3]
            seq2_len_div_seq1_len = similarity_split_line[4]
            aln_block_size = similarity_split_line[5]
            diff = similarity_split_line[6]
            idt = similarity_split_line[7]
            same = similarity_split_line[8]
            err_est2 = similarity_split_line[9]
            num_table_line_hits = num_table_line_hits + 1
    to_write_out = table_line_stripped + "\t" + GRCh38 + "\t" + seq1_len + "\t" + seq2_len + "\t" + seq2_len_div_seq1_len + "\t" + aln_block_size + "\t" + diff + "\t" + idt + "\t" + same + "\t" + err_est2 + "\t" + str(num_table_line_hits) + "\n"
    f_out.write(to_write_out)
    f_out.flush()

f_table.close()
f_similarity.close()
f_out.close()