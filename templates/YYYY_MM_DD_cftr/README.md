# Genes and barcodes 
The addressed gene is: 
CFTR: ch7:117480025-117668665 - Feature: ENSG00000001626.20 - Gene: ENST00000003084.11

## Amplicons 
For the CFTR it was used the following amplicons: 
amp1  (SIZE kb)
- Fwd: START - END	 
- Rev:	START - END


The barcode used are: 
- barcode 01 (CFTR, INFO ON THE PATIENT)

# Coverage of the bam files 
## CFTR
barcodes with good coverage: 
- barcode ...

barcodes with bad coverage: 
- barcode ...


# Create samplesheet 
Execute this command from the `bioinformatic_pipelines` directory 

Copy paste the lines with the variables in the terminal first. Then execute the command. 
- DATA_PATH is the absolute path where there barcode folders are 
- SAMPLESHEET_PATH is the absolute path of the samplelis.*.csv 

```shell 
DATA_PATH=""
SAMPLESHEET_PATH=""
./scripts-IBMM-nf-ontgeno/scripts_for_biologists/format_samplelist.sh "$DATA_PATH" "$SAMPLESHEET_PATH"
```


# Run the pipeline 
To run the pipeline for this data (from inside `vittoria` folder): 
If you're not in the right folder, execute this: 
```
# valid only locally 
cd /home/user_ubuntu/bioinformatic_pipelines/vittoria
```
CFTR
```shell
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file templates/YYYY_MM_DD_cftr/params.hac.yaml
```

TODO: update the path of the `-params-file` for an actual run the path for a .ymal file is "input/*.yaml"


