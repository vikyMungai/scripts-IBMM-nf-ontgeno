#!/bin/bash 

# Params
#   $1: absolute path of the output directory of the nf-ontgeno  

# Output
#       For each barcode, a file containing all information from both the .annotated and .phased.vcf files

# NB: execute the script from the directory of the repository 

# Example to execute it 
# ./variant_calling/merge_annotated_phased_vcf.sh "$INPUT_DIR" 
# with 
# INPUT_DIR="/home/user_ubuntu/bioinformatic_pipelines/vittoria/results/2026_06_04_hbb_hba2_phasing_hbb"


remove_headers(){
    # NB: this function is not used at the moment 
    # Params
    #   $1: list of files that needs to be filtered 
    #   $2: input directory where the files are 
    #   $3: ouput directory for the filtered files 

    # Output
    #       Removes the headers starting with "##" from all the files and saves the files after zipping them again in the $3 directory 

    FILES_LIST="$1"
    IN_FILES_DIR="$2"
    OUT_FILES_DIR="$3"


    for FILE in $FILES_LIST
    do  
        FILTERED_FILE="${OUT_FILES_DIR}/${FILE}"

        zcat "${IN_FILES_DIR}/${FILE}" | grep -v "^##" | bgzip > "$FILTERED_FILE"

    done 
}

# the foldernames depends on the nf-ontgeno outdir's structure 
ANN_FOLDER="vep"
PHASED_FOLDER="whatshap"
# added folders for new generated files  
ANN_AND_PHASED_FOLDER="annotated_and_phased"
ANN_FILTERED_FOLDER="annotated_filtered"
PHASED_FILTERED_FOLDER="phased_filtered"

# input directories 
INPUT_DIR="$1"
IN_ANN_DIR="${INPUT_DIR}/${ANN_FOLDER}"
IN_PHASED_DIR="${INPUT_DIR}/${PHASED_FOLDER}"
# output directory
OUT_DIR="${INPUT_DIR}/${ANN_AND_PHASED_FOLDER}"

# create the output directories 
if [[ ! -d "$OUT_DIR" ]]; then
    mkdir "$OUT_DIR"
    echo "create directory $OUT_DIR \n"
else
    echo "output directory already exists"
    echo "$OUT_DIR \n"
fi 


echo "Invoking python script...\n"

python3 ./variant_calling/merge_annotated_phased_vcf.py "$OUT_DIR" "$IN_ANN_DIR" "$IN_PHASED_DIR"
