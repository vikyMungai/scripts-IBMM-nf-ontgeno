# How to run this pipeline
NOTE the bash commands: if there are `<...>` it means that you have to put the file name or the path that is specific to your case. 

First thing, create a folder **outside** from the pipeline folder `nf-ontgeno` that will be used only from you. This is foundamental to not mix files with other users of the pipeline and the pipeline itself. 

```bash 
# form a folder outside of the pipeline `nf-ontgeno`
mkdir <folder_name>
# enter in the folder 
cd <folder_name>

# ----- example 
mkdir CFTR_analysis
cd CFTR_analysis
```
This will be the location from where you will be executing the pipeline. You can always check that you are in this folder by looking at the path in the command line, it must end with your folder name 
```bash 
# example 
user_ubuntu@IBMMNB4923:~/bioinformatic_pipelines/CFTR_analysis$
```

Here you create your `input` folder, where you will have all the file that are necessary to run the pipeline. 
A template has been prepared for you, you can use it directly (so yu don't have to create any file) or used it as a guide. 

## `CFTR_analysis/input` folder 

`input/CFTR_template` is strictly relative to the execute variant calling of the CFTR gene. To analyise other genes the files would need to be modified. 

### File params.hac.yaml

The name of the file is params.hac.yaml, 'hac' indicate the model of basecalling that has been used with the sequencing machine. In case it is not 'high accurancy', it is suggested to replace that part with the model of basecalling that has been used.  
The possibilities are: 
- fast basecalling: "fast"
- high accurancy: "hac"
- super accurate basecalling: "sup"

Main parameters: 
-	`outdir`: directory where the results are stored
-	`input`: samplelist.*.csv relative path in respect to the folder where you run the command `nextflow run`
-	`fasta`: the reference genome fasta file 
-	`bed`: .bed file with the region of the targeted gene (CFTR) 
-	`panel`: the panel for the phasing 
-	`basecalling_model`: the type of basecalling that was done with the nanopore device. To look at what basecalling model was used, open a fastq.gz file with `zcat <fastq.gz> | head | grep "basecall_model_version_id="` and see what is written after the string "basecall_model_version_id=".
```bash 
zcat barcode01/FBF58519_pass_barcode01_fe5b369b_c725c163_0.fastq.gz | head | grep "basecall_model_version_id="
# example of output 
dna_r10.4.1_e8.2_400bps_hac@v5.2.0 # it is written 'hac' in the name, so it is 'hac'. 
```
-   `genotype_model`: the model use for basecalling in the nanopore sequencing. It is the "basecall_model_version_id=" that you have read before with the command `zcat <fastq.gz> | head | grep "basecall_model_version_id="`. You have to put the absolute file of where is basecalling model is stored. You usually find it inside the pipeline `/home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/assets`
Add it here if it’s the same for all barcodes. Otherwise list it in the samplelist.*.csv file 
In case you don’t have that model you have to download it in this website https://github.com/nanoporetech/rerio/tree/master/clair3_models  

NB: if you are using this folder like this probably you need to change only the `basecalling_model` and `genotype_model` if you are using a different model. (only if the computer was already set up and you are not copy-pasting this folder in a new computer). 

### File samplelist.hac.csv

The part 'hac' has the same meaning as the 'params.hac.yaml' file. 

Copy the data from the folder of the nanopore device to the folder '/home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/data/raw_data'. Remeber to collect only the barcodes that you are interested in. 

You can copy the whole folder and remove the barcodes manually after it or remove the barcode that you don't need before copying them. 
```bash
# to copy the folder 
# leave the "" so it works even if the path has spaces 
cp "<absolute_path_folder>" "/home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/data/raw_data/<folder_data_name>"

# ------------------------ example 
cp -r "/mnt/c/Program Files (x86)/MinKNOW/2025_12_15_trialtoMK1D_SCN5A_Mattia/SC
N5A_trial/20251215_1353_MD-104464_FBA37759_96b58183/fastq_pass" "/home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/data/raw_data/fake_CFTR_fastq"
```
The `<absolute_path_folder>` is the folder where you have the fastq_pass of the sequencing. It is foundamental that you access it from the wsl and not from the "File Explorer" of the computer. 

To generate the `samplelist.hac.csv` execute the commands: 
```bash 
# move to the folder with the script (do not modifiy it)
cd /home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/scripts

# to execute the script (without adding the genotype for each line)
# substitute '<folder_data_name>' with the folder name
# substitute '<samplelist.*.csv>' with the samplelist file that is inside "input/CFTR_template"
# put "true" if inside the barcode* folders there is more than one fastq.gz file
./format_samplelist.sh "/home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/data/raw_data/<folder_data_name>" "/home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/input/CFTR_template/<samplelist.*.csv>" "run0" "A" "true"

#-------------------------- example with the `CFTR_analysis/data/raw_data/fake_raw_data` fastq.gz 
./format_samplelist.sh "/home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/data/raw_data/fake_CFTR_fastq" "/home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/input/CFTR_template/samplelist.hac.csv" "run0" "A" "true" 

# to add the genotype for each line 
./format_samplelist.sh "/home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/data/raw_data/fake_raw_data" "/home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis/input/CFTR_template/samplelist.hac.csv" "run0" "A" "true" "/home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/assets/r1041_e82_400bps_hac_v520"
```

Open the `CFTR_analysis/input/CFTR_template/samplelist.hac.csv` file to check that everything is correct. 

NB: If you need to add the genotyoe for each line, this will put the same genotype for each file and then you have to change it manually. In case you have troubles, contact the author. 
An example with some "fake_CFTR_fastq" was run to give an example of the output. 

### Other files
- .bed file: it is the bed file with the region of the targeted gene 
- .bcf file: panel to do the phasing. It is the same region of the bed file. 

## Run the pipeline
Make sure to set the environment variable `NXF_SINGULARITY_CACHEDIR` to avoid having to download Singularity containers repeatedly:
```bash
echo $NXF_SINGULARITY_CACHEDIR
```

If not defined, set it before running the pipeline to a directory with sufficient free disk space:
```bash
export NXF_SINGULARITY_CACHEDIR=/path/to/singularity_cache

# ------------------------------------------------ example 
export NXF_SINGULARITY_CACHEDIR="/home/user_ubuntu/bioinformatic_pipelines/singularity_cache"
```

Now you can run the pipeline
```bash 
# go into the folder CFTR_anaysis (or the folder you have created)
cd /home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis
# run the pipeline 
nextflow run /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/main.nf -c /home/user_ubuntu/bioinformatic_pipelines/nf-ontgeno/local.config -params-file input/2026_05_12_hbb_hba1_hba2_control_gDNA/params.hba1_phasing_hba1.yaml 
```

### Clean-up

To completely clean up all previous pipeline runs, the following files and folders need to be deleted:

```bash
# check to be in your folder 
cd /home/user_ubuntu/bioinformatic_pipelines/CFTR_analysis

rm -r work            # The working cache of the pipeline
rm -r .nextflow       # The Nextflow database containing information for nextflow log
rm -r <outdir>        # The folder with published results as defined in --outdir
rm .nextflow.log*     # The log files of previous runs
```
After this, it is no longer possible to resume a previous run, so be careful what you delete. To just delete a specific pipeline run, use `nextflow log` to get the ids of all runs and remove the run with `nextflow clean <RUN_NAME> -f`.

## Pipeline output

All result files will be published to the directory defined by the `outdir` parameter in the file params.hac.yaml.

# Additional notes 
The CFTR position is: 
ch7:117480025-117668665

website used: https://www.ncbi.nlm.nih.gov/datasets/gene/1080/ 

For the .bed file and the panel some padding was added to be sure that the gene was covered completly. So the region becomes: 
ch7:117470000-117690000

# Author of this README 
Vittoria Mungai 

email: vittoria.mungai@unibe.ch 