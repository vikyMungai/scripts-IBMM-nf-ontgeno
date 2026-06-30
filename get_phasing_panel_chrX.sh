#!/bin/bash

#Params
#		$1: chromosome of the gene. Example: 3 
#		$2: gene staring position. Example: 38000000
#		$3: gene end position. Example: 39000000

# Output
# 		3 .bcf files in teh same directory where from which you execute the comand to run the script. So, not necessary in the directory 
#		of the script. 
# 		The files are: 
# 		- 1kGP_high_coverage_Illumina.${CHROM}_${START}_${END}.filtered.SNV_INDEL_SV_phased_panel.bcf
# 		- 1kGP_high_coverage_Illumina.chr${CHROM}.filtered.SNV_INDEL_SV_phased_panel.vcf.gz
# 		- 1kGP_high_coverage_Illumina.chr${CHROM}.filtered.SNV_INDEL_SV_phased_panel.vcf.gz.tbi

# Example to run the script: 
#  ./get_phasing_panel.sh 3 38000000 39000000 

CHROM=$1 
START=$2 
END=$3 

# Get chromosome-wise phased vcf files and indices from the 1000 Genomes Project:
wget "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20220422_3202_phased_SNV_INDEL_SV/1kGP_high_coverage_Illumina.chr${CHROM}.filtered.SNV_INDEL_SV_phased_panel.v2.vcf.gz"
wget "http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20220422_3202_phased_SNV_INDEL_SV/1kGP_high_coverage_Illumina.chr${CHROM}.filtered.SNV_INDEL_SV_phased_panel.v2.vcf.gz.tbi"

# Remove the 'chr' prefix from the chromosome names to match the Ensembl reference:
tabix -h 1kGP_high_coverage_Illumina.chr${CHROM}.filtered.SNV_INDEL_SV_phased_panel.v2.vcf.gz chr${CHROM}:${START}-${END} | \
	awk '/^##contig=/{gsub(/\chr/, ""); print; next} /^#/{print; next} {gsub(/\chr/, ""); print}' | \
	bcftools view - -o 1kGP_high_coverage_Illumina.${CHROM}_${START}_${END}.filtered.SNV_INDEL_SV_phased_panel.bcf --output-type b
