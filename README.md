# scripts for nf-ontgeno pipeline 

## Structure 
    |
    ├── reference_genome
    |   └── create_fai_dict_from_fasta.sh 
    |
    ├── templates
        ├── general_instructions_CFTR.md
    |   ├── YYYY_MM_DD_CFTR
    |   └── YYYY_MM_DD_hbb_hba1_hba2
    |   
    ├── debug_pipeline_cmds.md 
    ├── format_bed_file.sh 
    ├── format_samplelist.sh
    ├── get_phasing_panel_chrX.sh
    ├── get_phasing_panel_with_chr.sh
    ├── get_phasing_panel.sh
    └── remove_chr_from_reference_fasta.sh 



#### reference_genome dir 
The script `create_fai_dict_from_fasta.sh` is used to create the indexed fasta file and the .dict file from a reference genome .fna 

#### templates
The templates containes the folders that can be used as a starting point for specific experiments. By the name we know what genes are analysed. 
It is supposed that amplicon sequencing with nanopore has been done to obtain the sequencing. 

#### other files
- debug_pipeline_cmds.sh: it contains useful commands to debug errors of the pipeline.
- format_bed_file.sh: it checks if a created .bed file is well formatted 
- format_samplelist.sh: it writes into a samplelist.*.csv file the list of samples that need to be analysed by the pipeline 
- get_phasing_panel_chrX.sh: it creates the panel for the chromosome X, but without the "chr" prefix. (which is compatible with the reference genome /home/user_ubuntu/data/references/Homo_sapiens.GRCh38.dna.primary_assembly.fa)
- get_phasing_panel_with_chr.sh: it creates the panel for the needed region with the "chr" prefix. The panels geenrated with this script are comaptible with the reference genome from the nanopore company "GCA_000001405.15_GRCh38_no_alt_analysis_set.fna" 
- get_phasing_panel.sh: it creates the panel for the needed region without the "chr" prefix, compatible with the reference genome /home/user_ubuntu/data/references/Homo_sapiens.GRCh38.dna.primary_assembly.fa
- remove_chr_from_reference_fasta.sh: it removes the "chr" prefix from the reference genome .fna 

## Notes 
If the pipeline needs to be executed in the micromamba environment nf-core use: 
```
cd 
cd programs/micromamba/
source bin/init.sh 
micromamba activate nf-core
cd 
cd bioinformatic_pipelines/vittoria/
```

to deactivate the environment use
```
micromamba deactivate
```

