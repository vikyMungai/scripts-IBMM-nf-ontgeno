#!/bin/bash
# Merges the fastq files of different barcodes that belong to the same sample
# this is needed to give as input the files post-basecalled (with SUP for example) to the nf-ontgeno. 
# Because fastq files of different barcodes have teh same naming.  

# Params
#   $1: relative path of the folder with the barcodes folders containg the fastq files. 
#   $2: barcode number for the result folder, suualy the samllest barcode is used as the single barcode assosciated to the new merged fastq
#   $3: list of barcodes of that sample, they need to be separate from spaces and between brackets, no spaces between the first word and the brackets, 
# same for the last word of the list, like the example below 

# Output 
#       It merges the .bam files all together 


# Example to execute the script from repo directory
# DATA_DIR="/home/user_ubuntu/bioinformatic_pipelines/vittoria/data/raw_data/2026_10_26_ORG15_NF1/sup_basecalling/nf1"
# BARCODE_ID="barcode17"
# BARCODE_FOLDERS="barcode17 barcode18 barcode19"

# Note: run it from the repo directory 
# ./configuration_pipeline/merge_fastq_files.sh "$DATA_DIR" "$BARCODE_ID" "$BARCODE_FOLDERS"

# activate micromamba nf-core environment to have samtools 
cd 
cd programs/micromamba/
source bin/init.sh 
micromamba activate nf-core
cd 


DATA_DIR="$1"
BARCODE_ID="$2"
BARCODE_FOLDERS="$3"

OUT_DIR="${DATA_DIR}/fastq_merged/${BARCODE_ID}"


# create the output directories 
if [[ ! -d "$OUT_DIR" ]]; then
    mkdir -p "$OUT_DIR"
    echo "create directory $OUT_DIR"
else
    echo "output directory already exists"
    echo "$OUT_DIR"
fi 

cd "$DATA_DIR"

for BARCODE in $BARCODE_FOLDERS; do 
    
    cd "$BARCODE" 
    FASTQ_LIST=$(ls ${DATA_DIR}/${BARCODE})

    MERGED_FASTQ="${OUT_DIR}/${BARCODE}.merged.fastq.gz"
    cat *.fastq.gz > "$MERGED_FASTQ"
    
    if [ $? -eq 0 ]; then 
        echo "$BARCODE merged successfully"
    fi 

    cd ..
done 


micromamba deactivate