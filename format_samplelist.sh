#!/bin/bash 

# Params
#   $1: input directory, where the barcode* folders are 
#   $2: absolute path with file name of the .csv output file where all the barcodes will be listed. 
#       Example: "/home/hugues_abriel/pipelines/vittoria/input/SCN5A_patients_rbk114.24/samplelist.hac.csv"
#   $3: run id 
#   $4: library (singular capital letter)
#   $5: The column name of the type of raw data that will be given to the pipeline (i.e. 'fastq', 'fastq_folder' 'bam', look at nextflow_schema.json flie for all posiibilities) 
#   $6: "true" if barcode's files are organised in "barcode[0-9]{2}" folders, "false" if there are no folders (like for bam files)
#   $7: genotype model, absolute path for the genotype model (optional)

# Output 
#       in the $1 directory will be created a file barcode*.fast.fastq.gz for each bardcode. 
#       the file $2 will be created with one row for each barcode in this format: 
#
#       sample,runid,library,fastq,genotype_model
#       barcode01,run0,A,/home/hugues_abriel/pipelines/vittoria/SCN5A_patients_rbk114.24/barcode01.fast.fastq.gz,/home/hugues_abriel/pipelines/nf-core-ontgeno/assets/r1041_e82_400bps_hac_v410
 
# Example to execute the script (without genotype_model)
# ./format_samplelist.sh "/home/user_ubuntu/bioinformatic_pipelines/vittoria/data/raw_data/SCN5A_Patients_NBD114.24" "/home/user_ubuntu/bioinformatic_pipelines/vittoria/input/trail_2026_05_12/samplelist.hac.csv" "run0" "A" "true"

# fake command line 
# ./format_samplelist.sh "/home/vittoria_ubuntu/vittoria_mungai_folder/SCN5A_patients_rbk114.24"  "/home/vittoria_ubuntu/vittoria_mungai_folder/sample_list_folder/samplelist.hac.csv" "run0" "A" "true" "/home/vittoria_ubuntu/vittoria_mungai_folder/fake_genotype_folder/fake_genotype_model.txt"

fasta_file_list()
{
    
}

INPUT_DIR="$1"
SAMPLELIST_FILE="$2"
RUN_ID="$3"
LIBRARY="$4"
DATA_TYPE="$5"
FOLDERS_FLAG="$6"
# echo "DB: numer of arguments $#"

if [ "$#" -eq 5 ]; then 
    GENOTYPE_MODEL="$6"
fi

cd $INPUT_DIR

# column name of the fastq files depends on FOLDERS_FLAG variable 
FASTQ_COL="$DATA_TYPE"

# --old code 
# if $FOLDERS_FLAG; then 
#    FASTQ_COL="${DATA_TYPE}_folder"
# fi 
# -- end old code 


# printing the columns' name 
if [ ! -z $GENOTYPE_MODEL ]; then 
    echo "sample,runid,library,${FASTQ_COL},genotype_model" > "$SAMPLELIST_FILE" 
else 
    echo "sample,runid,library,${FASTQ_COL}" > "$SAMPLELIST_FILE"
fi 

# if each barcode has more than one .fastq.gz file, only the folder name is written in the samplelist.csv file 
if $FOLDERS_FLAG; then 
    BARCODE_FOLDERS=$(ls | grep -E 'barcode[0-9]+$')

    for BARCODE in $BARCODE_FOLDERS; do 
   
        if [ ! -z $GENOTYPE_MODEL ]; then 
            echo "$BARCODE,$RUN_ID,$LIBRARY,$INPUT_DIR/$FILENAME,$GENOTYPE_MODEL" >> "$SAMPLELIST_FILE"
        else 
            echo "$BARCODE,$RUN_ID,$LIBRARY,$INPUT_DIR/$BARCODE" >> "$SAMPLELIST_FILE"
        fi 
        
    done 

else
    if [ $FASTQ_COL == 'bam' ]; then 

    else  # TODO: implement how to list the .fastq.gz flies only 
        echo "Fastq.gz list of files only, function not implemented"
    fi 
fi 


echo "${SAMPLELIST_FILE} created"