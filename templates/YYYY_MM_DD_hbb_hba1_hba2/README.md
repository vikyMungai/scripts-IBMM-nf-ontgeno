# Genes and barcodes 
The addressed genes are 
- HBB: ch11:5225464-5227071
- HBA1: ch16:176680-177522 
- HBA2: ch16:172876-173710

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

The barcode used are: 
- barcode 01 (GENES INCLUDED)

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


# Run the pipeline 
To run the pipeline for this data (from inside `vittoria` folder): 
If you're not in the right folder, execute this: 
```
# valid only locally 
/home/user_ubuntu/bioinformatic_pipelines/vittoria
```
HBB
```
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file templates/YYYY_MM_DD_hbb_hba1_hba2/params.phasing_hba1.hac.yaml
```
for HBA1
```
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file templates/YYYY_MM_DD_hbb_hba1_hba2/params.phasing_hba1.hac.yaml
```
for HBA2
```
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file templates/YYYY_MM_DD_hbb_hba1_hba2/params.phasing_hba1.hac.yaml
```

TODO: update the path of the `-params-file` for an actual run the path for a .ymal file is "input/*.yaml"

## Additional information 
I used the bcftools instead of clair3 for all HBA1, because it was giving an error as it was not identifying any variant and not creating the .vcf file. This would have than cause the pipeline to crash. 

