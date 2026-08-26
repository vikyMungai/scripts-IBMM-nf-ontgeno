# Genes and barcodes 
The addressed gene is: 
CFTR: ch7:117480025-117668665

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

# Run the pipeline 
To run the pipeline for this data (from inside `vittoria` folder): 
If you're not in the right folder, execute this: 
```
# valid only locally 
cd /home/user_ubuntu/bioinformatic_pipelines/vittoria
```
HBB
```
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file templates/YYYY_MM_DD_CFTR/params.hac.yaml
```

TODO: update the path of the `-params-file` for an actual run the path for a .ymal file is "input/*.yaml"

## Additional information 
I used the bcftools instead of clair3 for all HBA1, because it was giving an error as it was not identifying any variant and not creating the .vcf file. This would have than cause the pipeline to crash. 

