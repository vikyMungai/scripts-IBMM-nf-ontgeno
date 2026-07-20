# Genes and barcodes 
The addressed genes are 
- ALPL: ch1:21508813-21579441 (forward strand)
- NF1: ch17:31094883-31382116 (forward strand)
- CYP19A1: ch15:51208057-51338606  (reverse strand)

The barcode used are: 
- barcode 03 (ALPL NC_000001.11)
- barcode 04 (CYP19A1 NC_ 000015.10)
- barcode 05 (NF1  NC_000017.11)

### Information of the genes 
These are helpful for the filtering of the variants 
#### ALPL
    - Ensembl ENSG00000162551
    - MANE Select ENST00000374840.8 
#### NF1
    - Ensembl ENSG00000196712
    - MANE Select ENST00000358273.9
#### CYP19A1
    - Ensembl ENSG00000137869
    - MANE Select ENST00000396402.6


# Coverage of the bam files 
### For ALPL 
Bad coverage was shown by the barcodes:
- barcode ...

Good coverage was shown by the barcodes 
- barcode ....

### For NF1 
Bad coverage was shown by the barcodes:
- barcode .... 

Good coverage was shown by the barcodes 
- barcode ....

### For CYP19A1 
Bad coverage was shown by the barcodes:
- barcode ....

Good coverage was shown by the barcodes 
- barcode ....

# To run the pipeline for this data 

### ALPL
```
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file input/2026_07_14_ALPL_NF1_CYP19A1/params.alpl.yaml
```

### NF1
```
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file input/2026_07_14_ALPL_NF1_CYP19A1/params.nf1.yaml
```


### CYP19A1
```
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file input/2026_07_14_ALPL_NF1_CYP19A1/params.cyp19a1.yaml
```

## Note to run the pipeline 
As more than one region is asked and they are in different chromosome, eagle2 cannot run with multiple panels at the same time. For this reason it is important to run the same pipeline (with the same .bed file) with different phasing panels. 
