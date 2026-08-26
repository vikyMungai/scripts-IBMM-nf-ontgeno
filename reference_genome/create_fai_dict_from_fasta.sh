#!/bin/bash

# Params
#   $1: reference fasta file zipped (absolute path) 
#   $2: output directory (absolute path)

# Output 
#       It creates the .fai and .dict of the reference given


# Example to execute the script (without genotype_model) from repo directory
# ./reference_genome/create_fai_dict_from_fasta.sh "/home/user_ubuntu/data/references/reference_adaptive_sampling/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz"
REF_FNA_ZIP="$1"
REF_FNA="${REF_FNA_ZIP%.*}"
DICT_FILE="${REF_FNA%.*}.dict"


gzip -dk "${REF_FNA_ZIP}"
samtools faidx "${REF_FNA}"
samtools dict "${REF_FNA}" --output ${DICT_FILE}