#!/usr/bin/env python3
import sys
import os
import cyvcf2
'''
OUT_DIR="/home/user_ubuntu/bioinformatic_pipelines/vittoria/results/2026_06_04_hbb_hba2_phasing_hbb/annotated_and_phased"
OUT_ANN_DIR="/home/user_ubuntu/bioinformatic_pipelines/vittoria/results/2026_06_04_hbb_hba2_phasing_hbb/annotated_and_phased/annotated_filtered"
OUT_PHASED_DIR="/home/user_ubuntu/bioinformatic_pipelines/vittoria/results/2026_06_04_hbb_hba2_phasing_hbb/annotated_and_phased/phased_filtered"
python3 ./variant_calling/merge_annotated_phased_vcf.py "$OUT_DIR" "$OUT_ANN_DIR" "$OUT_PHASED_DIR"
'''

'''
TODO: remove
def function(num1,num2,num3):
  return(int(num1)+int(num2)+int(num3))
'''

if __name__ == "__main__":
    out_dir = sys.argv[1]
    annotated_dir = sys.argv[2]
    phased_dir = sys.argv[3]

    print(out_dir)
    print(annotated_dir)
    print(phased_dir)
    

    ann_files = [ os.path.join(annotated_dir, f) for f in os.listdir(annotated_dir) if f.endswith(".annotated.tab.gz") ]
    print(ann_files)
    print(ann_files[1])  
    
    phased_files = [  os.path.join(phased_dir, f) for f in os.listdir(phased_dir) if f.endswith(".phased.vcf.gz") ]    
    print(phased_files)  
     
    vcf = cyvcf2.Reader(phased_files[1])








'''
ANNOTATED_DIR="$1"
ANNOTATED_DIR="/home/user_ubuntu/bioinformatic_pipelines/vittoria/results/2026_06_11_hbb_hba2_phasing_hbb/vep"

PHASED_DIR="$2"
PHASED_DIR="/home/user_ubuntu/bioinformatic_pipelines/vittoria/results/2026_06_11_hbb_hba2_phasing_hbb/whatshap"
OUT_DIR="$3"


ANNOTATED_FILE="/home/user_ubuntu/bioinformatic_pipelines/vittoria/results/2026_06_11_hbb_hba2_phasing_hbb/vep/barcode01.annotated.tab.gz"
PHASED_FILE="/home/user_ubuntu/bioinformatic_pipelines/vittoria/results/2026_06_11_hbb_hba2_phasing_hbb/whatshap/barcode01.phased.vcf.gz"
OUT_DIR="/home/user_ubuntu/bioinformatic_pipelines/vittoria/trouble_shooting"
'''