## Renaming benchmark set files for FTP release #####################
#### Downloaded files/ directory from https://drive.google.com/drive/folders/1JKzvCaCzyCEWwN0MIeABnlZo4w08geqf 6/7/21 10 AM
## Downloaded dipcall outputs from linked subdirectories

## Get initial directory structure
tree > initial.tree 

## Removing unneeded files
# Gene coordinates for full medically relevant genes list will be made available through CRMG github repo
rm \
    GRCh37/SupplementaryFiles/GRCh37_ENSEMBL_biomart_all_medical_gene_coordinates.bed \
    GRCh38/SupplementaryFiles/GRCh38_ENSEMBL_biomart_all_medical_gene_coordinates.bed \
    GRCh37/SupplementaryFiles/HG002v11-align2-GRCh37.html \
    GRCh38/SupplementaryFiles/HG002v11-align2-GRCh38.html \
    CHM13v1.0/SupplementaryFiles/HG002v11-align2-chm13.20200921.withGRCh38chrY.html

## Get initial directory structure
tree > initial.tree  

## Generate initial MD5 list
find . -type f -exec md5 {} \; > initial.md5

## Make directory for CHM13 small variant benchmarkset
mkdir CHM13v1.0/SmallVariant
mv CHM13v1.0/HG002_CHM13v1.0_difficult_medical_gene_smallvar_benchmark_v1.00.01_draft.bed \
    CHM13v1.0/HG002v11-align2-chm13.20200921.withGRCh38chrY.dip.vcf.gz \
    CHM13v1.0/HG002v11-align2-chm13.20200921.withGRCh38chrY.dip.vcf.gz.tbi \
    CHM13v1.0/SmallVariant

## Update CHM13 version name
find . -type f \
    -exec rename --make-dirs 's/chm13.20200921.withGRCh38chrY/CHM13v1.0/' '{}' \;

find . -type d \
    -exec rename --make-dirs 's/chm13.20200921.withGRCh38chrY/CHM13v1.0/' '{}' \+


## SmallVariant Benchmark Sets
# From 
#   {CHM13v1.0,GRCh37,GRCh38}/SmallVariant/HG002_*_difficult_medical_gene_smallvar_benchmark_v1.00.01.*
# To
#  {CHM13v1.0,GRCh37,GRCh38}/SmallVariant/HG002_{GRCh37,GRCh38,CHM13}_CMRG_smallvar_v1.00*
find . -type f \
    -exec rename 's/difficult_medical_gene_smallvar_benchmark_v1.00.01/CMRG_smallvar_v1.00/' '{}' \;

## Structural Variant Benchmark Sets
# From 
#   {CHM13v1.0,GRCh37,GRCh38}/StructuralVariant/HG002_*_difficult_medical_gene_SV_benchmark_v1.00.01.*
# To
#  {CHM13v1.0,GRCh37,GRCh38}/StructuralVariant/HG002_{GRCh37,GRCh38,CHM13}_CMRG_SV_v1.00*
find . -type f \
    -exec rename 's/difficult_medical_gene_SV_benchmark_v1.00.01/CMRG_SV_v1.00/' '{}' \;

## CHM13 GRCh38 Equivalent Bed
mv CHM13v1.0/SupplementaryFiles/HG002_GRCh38_CMRG_smallvar_v1.00_draft_CHM13v1.0equivalent.bed \
    CHM13v1.0/SupplementaryFiles/HG002_CHRM13_CMRG_smallvar_v1.00_GRCh38-equiv-regions_draft.bed

## Fixing sample names
mkdir wrong_sample_name fixed_sample_name

mv */{SmallVariant,StructuralVariant}/*{vcf.gz,vcf.gz.tbi} \
    wrong_sample_name

echo "syndip HG002\n" > sample_rename.txt
for vcf in  wrong_sample_name/*vcf.gz; do
    bcftools reheader -s sample_rename.txt $vcf \
        > fixed_sample_name/$vcf:t
    tabix fixed_sample_name/$vcf:t
done

## Moving files back
cp fixed_sample_name/HG002_GRCh37_CMRG_SV_v1.00.vcf.gz* GRCh37/StructuralVariant/  
cp fixed_sample_name/HG002_GRCh37_CMRG_smallvar_v1.00.vcf.gz* GRCh37/SmallVariant/  
cp fixed_sample_name/HG002_GRCh38_CMRG_SV_v1.00.vcf.gz* GRCh38/StructuralVariant/  
cp fixed_sample_name/HG002_GRCh38_CMRG_smallvar_v1.00.vcf.gz* GRCh38/SmallVariant/  
cp fixed_sample_name/HG002v11-align2-CHM13v1.0.dip.vcf.gz* GRCh38/SmallVariant/  

## Sorting bed files
mkdir unsorted_beds sorted_beds
cp {GRCh37,GRCh38}/*Variant/*bed unsorted_beds
cp {GRCh37,GRCh38}/SupplementaryFiles/*CMRG_benchmark_gene_coordinates.bed unsorted_beds
cp CHM13v1.0/SupplementaryFiles/HG002_CHRM13_CMRG_smallvar_v1.00_GRCh38-equiv-regions_draft.bed  unsorted_beds

for bed in unsorted_beds/*GRCh37*bed; do
    sortBed -g ../human.b37.genome -i $bed \
        > sorted_beds/$bed:t
done

for bed in unsorted_beds/*GRCh38*bed; do
    sortBed -g ../human.hg38.genome -i $bed \
        > sorted_beds/$bed:t
done

## Moving files back
mv sorted_beds/HG002_CHRM13_CMRG_smallvar_v1.00_GRCh38-equiv-regions_draft.bed CHM13v1.00/SupplementaryFiles/
mv sorted_beds/HG002_GRCh37_CMRG_SV_v1.00.bed GRCh37/StructuralVariant/
mv sorted_beds/HG002_GRCh37_CMRG_smallvar_v1.00.bed GRCh37/SmallVariant/
mv sorted_beds/HG002_GRCh38_CMRG_SV_v1.00.bed GRCh38/StructuralVariant/
mv sorted_beds/HG002_GRCh38_CMRG_smallvar_v1.00.bed GRCh38/SmallVariant/

## Final MD5 list to verify renaming
find . -type f -exec md5 {} \; > chksum.md5

## Get final directory structure
tree > final.tree 