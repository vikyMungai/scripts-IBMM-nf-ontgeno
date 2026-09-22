# Genes and barcodes 
The addressed genes are 
- HBB: chr11:5225464-5227071 - Feature: ENST00000335295.4 - Gene: ENSG00000244734.6 
- HBA1: chr16:176680-177522 - Feature: ENST00000320868.9 - Gene: ENSG00000206172.10
- HBA2: chr16:172876-173710 - Feature: ENST00000251595.11 - Gene: ENSG00000188536.15 

## Amplicons 
For the HBB, HBA1, HBA2 it was used: 
amp1 for HBB (SIZE kb)
- Fwd1_HBB: START - END	 
- Rev4_HBB	START - END
amp2 for HBA1 (SIZE kb)
- Fwd1_HBA1: START - END
- Rev1_HBA1: START - END
amp3 for HBA2 (SIZE kb)
- Fwd1_HBA2	START - END
- Rev1_HBA2	START - END

The barcode used for HBB/HBA2 are: 
- barcode ...

The barcode used for HBA1 are: 
- barcode ...

# Coverage of the bam files 
## HBB 
barcodes with good coverage: 
- barcode ...

barcodes with bad coverage: 
- barcode ...

## HBA2 
barcodes with good coverage: 
- barcode ...

barcodes with bad coverage: 
- barcode ...

## HBA1 
barcodes with good coverage: 
- barcode ...

barcodes with bad coverage: 
- barcode ...


# Create samplesheet 
Execute this command from the `bioinformatic_pipelines` directory 

Copy paste the lines with the variables in the terminal first. Then execute the command. 
- DATA_PATH is the absolute path where there barcode folders are 
- SAMPLESHEET_PATH is the absolute path of the samplelis.*.csv 
for HBB
```shell 
DATA_PATH=""
SAMPLESHEET_PATH=""
./scripts-IBMM-nf-ontgeno/simplified_scripts/format_samplelist.sh "$DATA_PATH" "$SAMPLE_SHEETPATH"
```

for HBA2
```shell
DATA_PATH=""
SAMPLESHEET_PATH=""
./scripts-IBMM-nf-ontgeno/simplified_scripts/format_samplelist.sh "$DATA_PATH" "$SAMPLE_SHEETPATH"
```

for HBA1 
```shell 
DATA_PATH=""
SAMPLESHEET_PATH=""
./scripts-IBMM-nf-ontgeno/simplified_scripts/format_samplelist.sh "$DATA_PATH" "$SAMPLE_SHEETPATH"
```

# Run the pipeline 
To run the pipeline for this data (from inside `vittoria` folder): 
If you're not in the right folder, execute this: 
```
# valid only locally 
cd /home/user_ubuntu/bioinformatic_pipelines/vittoria
```
HBB
```shell
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file templates/YYYY_MM_DD_hbb_hba1_hba2/params.phasing_hbb.hac.yaml
```
for HBA1
```shell
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file templates/YYYY_MM_DD_hbb_hba1_hba2/params.phasing_hba1.hac.yaml
```
for HBA2
```shell
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file templates/YYYY_MM_DD_hbb_hba1_hba2/params.phasing_hba1.hac.yaml
```

TODO: update the path of the `-params-file` for an actual run the path for a .ymal file is "input/*.yaml"

## Additional information 
I used the bcftools instead of clair3 for all HBA1, because it was giving an error as it was not identifying any variant and not creating the .vcf file. This would have than cause the pipeline to crash. 

