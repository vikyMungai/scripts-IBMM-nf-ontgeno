#!/bin/bash

# NB: needs to be executed in a micromamba environment 

#Params
#		$1: reference fasta file's absolute path with 'chr'
#       $2: directory of the reference fasta file without 'chr'  (without '/'' at the end)

# Output
# 		the reference fasta file without 'chr' will be generated 

# from `~/bioinformatic_pipelines/vittoria`` folder 
# ./scripts/remove_chr_from_reference_fasta.sh "/home/user_ubuntu/data/references/reference_adaptive_sampling/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna" "/home/user_ubuntu/data/references/reference_adaptive_sampling/no_chr"

REF_FILE="$1"
NEW_REF_DIR="$2"
NEW_REF_FILE="${NEW_REF_DIR}/$(basename ${REF_FILE%.*}).no_chr.fna"
# Remove 'chr' prefix from contig names in the FASTA
sed 's/^>chr/>/' "$REF_FILE" > "$NEW_REF_FILE"

echo "created fasta file $NEW_REF_FILE"

# Re-index
samtools faidx "$NEW_REF_FILE"

samtools dict "$NEW_REF_FILE" --output "${NEW_REF_FILE%.*}.dict"

echo "Reference fasta file created with success (with index .fnai and dictionary .dict)"
echo "$2"

