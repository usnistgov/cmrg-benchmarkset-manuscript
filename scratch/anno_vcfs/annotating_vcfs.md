# Annotating MRG VCF with gene names

## Bed files for annotation
Sorting exon bed, downloading ref genome faidx from GIAB FTP site
```
bedtools sort \
    -faidx ../../resources/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta.gz.fai \
    -i grch38_exon.bed \
    > grch38_exon_sorted.bed
```

Sorting gene bed with excluding mito
```
grep -v "chrMT" grch38_gene.bed > grch38_gene_noMT.bed 

bedtools sort \
    -faidx ../../resources/GCA_000001405.15_GRCh38_no_alt_analysis_set.fasta.gz.fai \
    -i grch38_gene_noMT.bed \
    > grch38_gene_sorted.bed
```
Making header file saved as `hdr.txt`
```
##INFO=<ID=GENE,Number=1,Type=String,Description="Gene name">
##INFO=<ID=EXON,Number=1,Type=String,Description="ENSEMBL exon ID">
```
## Annotating Small Variant VCF

### Annotating with gene info
```
bcftools annotate \
    -a grch38_gene_sorted.bed \
    -c CHROM,FROM,TO,INFO/GENE \
    -h hdr.txt \
    grch38_smvar.vcf.gz \
    > grch38_smvar_gene.vcf
``` 

### Annotating with exon info

```
bcftools annotate \
    -a grch38_exon_sorted.bed.gz \
    -c CHROM,FROM,TO,-,-,INFO/EXON \
    -h hdr.txt \
    grch38_smvar_gene.vcf \
    > grch38_smvar_anno.vcf
``` 


## Annotating SV vcf
### Annotating with gene info
```
bcftools annotate \
    -a grch38_gene_sorted.bed \
    -c CHROM,FROM,TO,INFO/GENE \
    -h hdr.txt \
    grch38_sv.vcf.gz \
    > grch38_sv_gene.vcf
``` 

### Annotating with exon info
```
bcftools annotate \
    -a grch38_exon_sorted.bed.gz \
    -c CHROM,FROM,TO,-,-,INFO/EXON \
    -h hdr.txt \
    grch38_sv_gene.vcf \
    > grch38_sv_anno.vcf
``` 

## Converting annotated VCFs to table

### Small Var Table
```
bcftools query \
    -f '%CHROM\t%POS\t[ %GT]\t%TYPE\t%INFO/GENE\t%INFO/EXON\t%REF\t%ALT\n' \
    grch38_smvar_anno.vcf \
    > grch38_smvar.tbl
```

## Structural Var Table
TODO - update
```
bcftools query \
    -f '%CHROM\t%POS\t[ %GT]\t%TYPE\t%REPTYPE\t%BREAKSIMLENGTH\t%INFO/GENE\t%INFO/EXON\t%REF\t%ALT\n' \
    grch38_sv_anno.vcf \
    > grch38_sv.tbl
```


