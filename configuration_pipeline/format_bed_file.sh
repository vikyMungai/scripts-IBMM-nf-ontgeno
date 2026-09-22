#!/bin/bash

# it checks if the bed file is well formatted, the separator must be a tab "\t". 
# In case it cannot read 3 columns it will filter for the spaces "\s" and replace them with the a single tab. 
# this script checks only for a bed file to be well formatted and substitute only spaces. 
# NB: This scripts checks for valid coordinates in human chromosomes. 

# Params: 
#   $1: absolute path of the bed file 

# Output 
#       in the .bed file $1 is overwirtten

# To execute the file, run the command: 
#  ./format_bed_file.sh "<absolute_path>"
# example: 
#  ./format_bed_file.sh "/home/user_ubuntu/bioinformatic_pipelines/vittoria/input/2026_05_12_hbb_hba1_hba2_control_gDNA/region.hba1_hba2.bed"

BED_FILE="$1"
TEMP_FIXED_BED=$(mktemp)

# automatic removal 
trap "rm -f $TEMP_FIXED_BED" EXIT

# Convert spaces to tabs (one or more spaces)
sed 's/ \+/\t/g' "$BED_FILE" > "$TEMP_FIXED_BED"

# Validate BED file 
if awk '
{
    # Check column count
    if (NF != 3) {
        print "Line " NR ": Expected 3 columns, found " NF
        exit 1
    }
    
    # Check chromosome name
    if ($1 !~ /^(([1-9]|1[0-9]|2[0-2])|[XYM]|MT)$/) {
        print "Line " NR ": Invalid chromosome: " $1
        exit 1
    }
    
    # Check coordinates are integers
    if ($2 !~ /^[0-9]+$/ || $3 !~ /^[0-9]+$/) {
        print "Line " NR ": Coordinates must be integers. Start: " $2 " End: " $3
        exit 1
    }
    
    # Check start < end
    if ($2 >= $3) {
        print "Line " NR ": Start must be less than end. Start: " $2 " End: " $3
        exit 1
    }
}
END {
    print "BED file validation passed for all " NR " lines"
}' "$TEMP_FIXED_BED"; then
    mv "$TEMP_FIXED_BED" "$BED_FILE"
    echo "BED file successfully formatted and validated"
else
    echo "Error: BED file validation failed"
    exit 1
fi
