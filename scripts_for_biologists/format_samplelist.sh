#!/bin/bash 

# Params
#   $1: input directory, where the barcode* folders are 
#   $2: absolute path with file name of the .csv output file where all the barcodes will be listed. 
#       Example: "/home/hugues_abriel/pipelines/vittoria/input/SCN5A_patients_rbk114.24/samplelist.hac.csv"

# Output
#       the file $2 will be created with one row for each barcode in this format: 
#
#       sample,runid,library,fastq
#       barcode01,run0,A,/home/hugues_abriel/pipelines/vittoria/SCN5A_patients_rbk114.24/barcode01.fast.fastq.gz
 
# Example to execute the script 
# ./scripts-IBMM-nf-ontgeno/format_samplelist.sh "/home/user_ubuntu/bioinformatic_pipelines/vittoria/data/raw_data/SCN5A_Patients_NBD114.24" "/home/user_ubuntu/bioinformatic_pipelines/vittoria/input/trail_2026_05_12/samplelist.hac.csv"

DATA_DIR="$1"
SAMPLELIST_FILE="$2"
RUN_ID="run0"
LIBRARY="A"
DATA_TYPE="fastq_folder"
FOLDERS_FLAG="true"

cd $DATA_DIR

# column name of the fastq files depends on FOLDERS_FLAG variable 
FASTQ_COL="$DATA_TYPE"


# printing the columns' name 
if [ ! -z $GENOTYPE_MODEL ]; then 
    echo "sample,runid,library,${FASTQ_COL},genotype_model" > "$SAMPLELIST_FILE" 
else 
    echo "sample,runid,library,${FASTQ_COL}" > "$SAMPLELIST_FILE"
fi 

BARCODE_FOLDERS=$(ls | grep -E 'barcode[0-9]+$')

for BARCODE in $BARCODE_FOLDERS; do 

    if $FOLDERS_FLAG; then # only put the barcode folder name 
        FILE=$BARCODE
    else # add the only file present for the barcode 
        
        if [ $FASTQ_COL == 'bam' ]; then 
            OUTPUT_FILE=$(ls $BARCODE | grep -E '.bam$')
        elif [ $FASTQ_COL == 'fastq' ]; then 
            OUTPUT_FILE=$(ls $BARCODE | grep -E '.fastq') # TODO: check extension 
        fi

        FILE="$BARCODE/$OUTPUT_FILE"
    fi  

    if [ ! -z $GENOTYPE_MODEL ]; then 
        echo "$BARCODE,$RUN_ID,$LIBRARY,$DATA_DIR/$FILE,$GENOTYPE_MODEL" >> "$SAMPLELIST_FILE"
    else 
        echo "$BARCODE,$RUN_ID,$LIBRARY,$DATA_DIR/$FILE" >> "$SAMPLELIST_FILE"
    fi 
    
done 

echo "${SAMPLELIST_FILE} created"
