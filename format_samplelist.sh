#!/bin/bash 

# Params
#   $1: input directory, where the barcode* folders are 
#   $2: absolute path with file name of the .csv output file where all the barcodes will be listed. 
#       Example: "/home/hugues_abriel/pipelines/vittoria/input/SCN5A_patients_rbk114.24/samplelist.hac.csv"
#   $3: run id (like "run0")
#   $4: library (singular capital letter, like "A")
#   $5: The column name of the type of raw data that will be given to the pipeline (i.e. 'fastq', 'bam', 'fastq_folder' 
#       look at schema_input.json flie for all possibilities. Look at filed "oneOf") 
#   $6: "true" if barcode's files are organised in "barcode[0-9]{2}" folders and there is more than one file,
#        "false" if there is only one file per folder 
#   $7: genotype model, absolute path for the genotype model (optional)

# Output 
#       in the $1 directory will be created a file barcode*.fast.fastq.gz for each bardcode. 
#       the file $2 will be created with one row for each barcode in this format: 
#
#       sample,runid,library,fastq,genotype_model
#       barcode01,run0,A,/home/hugues_abriel/pipelines/vittoria/SCN5A_patients_rbk114.24/barcode01.fast.fastq.gz,/home/hugues_abriel/pipelines/nf-core-ontgeno/assets/r1041_e82_400bps_hac_v410
 
# Example to execute the script (without genotype_model)
# ./format_samplelist.sh "/home/user_ubuntu/bioinformatic_pipelines/vittoria/data/raw_data/SCN5A_Patients_NBD114.24" "/home/user_ubuntu/bioinformatic_pipelines/vittoria/input/trail_2026_05_12/samplelist.hac.csv" "run0" "A" "fastq_folder" "true"

# fake command line 
# ./format_samplelist.sh "/home/vittoria_ubuntu/vittoria_mungai_folder/SCN5A_patients_rbk114.24"  "/home/vittoria_ubuntu/vittoria_mungai_folder/sample_list_folder/samplelist.hac.csv" "run0" "A" "fastq_folder" "true" "/home/vittoria_ubuntu/vittoria_mungai_folder/fake_genotype_folder/fake_genotype_model.txt"

DATA_DIR="$1"
SAMPLELIST_FILE="$2"
RUN_ID="$3"
LIBRARY="$4"
DATA_TYPE="$5"
FOLDERS_FLAG="$6"

if [ "$#" -eq 7 ]; then 
    GENOTYPE_MODEL="$7"
fi

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