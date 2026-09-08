import sys
import os 
import pandas as pd
import gzip
import re 


def open_file(filename):
    """
    Open plain-text or gzipped files.
    
    Params
        filename: absolute path of the file 

    Return
        the pointer to the open file 
    """
    if str(filename).endswith(".gz"):
        return gzip.open(filename, "rt")
    return open(filename, "r")

def from_phased_vcf_to_dataframe(vcf_file): 
    """
    Read the *phased.vcf file and create a Dataframe with all the data 
        
    Params
        vcf_file: absolute path of the phased.vcf file
        
    Return
        the pointer to the dataframe with all teh data contained in the vcf file 

    NB: the column "ID" is not kept because the same information is already stored into the column "Existing_variation" in the *.annotated.tab file 
    """
    vcf_rows = []
    columns = []

    with open_file(vcf_file) as f:
        for line in f:
                # skip all the lines that contain the headers (which start with ##)
            if line.startswith("#") or not line.strip():
                continue
            else: 
                # extract the information for all data rows 
                fields = line.rstrip("\n").split("\t")

                vcf_rows.append({
                    "CHROM": fields[0],
                    "POS": int(fields[1]),   
                    "REF": fields[3],
                    "ALT": fields[4],
                    "QUAL_PHASING": fields[5],
                    "FILTER_PHASING": fields[6],
                    "INFO_PHASING": fields[7],
                    "FORMAT_PHASING": fields[8],
                    "PHASING": fields[9]
                })

    # create a frame that contain all information of the vcf file 
    vcf_df = pd.DataFrame(vcf_rows)

    return(vcf_df)

def from_annotated_tab_to_dataframe(annotated_file): 
    """
    Read the *.annotated.tab file and create a Dataframe with all the data 
        
    Params
        annotated_file: absolute path of the *.annotated.tab file
        
    Return
        the pointer to the dataframe with all the data contained in the tab file 
    """
    # read *.annotated.tab
    with open_file(annotated_file) as f:

        # Extract the header of the file 
        for line in f:
            if line.startswith("#Uploaded_variation"):
                header = line.lstrip("#").rstrip("\n").split("\t")
                break

        annotation_df = pd.read_csv(
            f,
            sep="\t",
            names=header,
            dtype=str
        )

    # split column "Uploaded_variation"

    # separate CHROM, POS, REF/ALT
    split_columns = annotation_df["Uploaded_variation"].str.split(
        "_", n=3, expand=True
    )

    # add columns for CHROM, POS, REF and ALT to enable the join with the *.phased.vcf file 
    annotation_df["CHROM"] = split_columns[0]
    annotation_df["POS"] = pd.to_numeric(split_columns[1])
    
    # split REF and ALT in two different columns 
    ref_alt = split_columns[2].str.split("/", n=1, expand=True)

    annotation_df["REF"] = ref_alt[0]
    annotation_df["ALT"] = ref_alt[1]

    return(annotation_df)


def merge_annotation_phased(phased_file, annotated_file, merged_file):
    """
    Merged the *.annotated.tab file and the .phased.vcf files data using the coordinates of the variants as join columns 
        
    Params
        phased_file: absolute path of the *.phased.vcf file
        annotated_file: absolute path of the *.annotated.tab file
        merged_file: absolute path of the *.annotated_phased.tab file
        
    Return
        None 
        Creates the file *.annotated_phased.tab file
    """

    phased_df = from_phased_vcf_to_dataframe(phased_file)

    annotation_df = from_annotated_tab_to_dataframe(annotated_file)

    merged_df = annotation_df.merge(
        phased_df,
        on=["CHROM", "POS", "REF", "ALT"],
        how="left",
        validate="many_to_one"
    )

    merged_df = merged_df.drop(columns= ["CHROM", "POS", "REF", "ALT"]) 

    # save the merged DataFrames in a single csv file 
    merged_df.to_csv(
        merged_file,
        sep="\t",
        index=False
    )

    print(f"Output written to: {merged_file}")
    # check that the joining was successful (the number of the rows must match)
    print(f"Annotated rows: {len(annotation_df)}")
    print(f"Merged rows:    {len(merged_df)}\n")


def get_files_list(dir, suffix):
    """
    Extract the list of all the files that are present in the directory and that has the suffix 
        
    Params
        dir: absolute path of the directory 
        suffix: suffix of the selected files 
        
    Return
        List of the absolute path of all files 
    """
    files_list = [ os.path.join(dir, f) for f in os.listdir(dir) if f.endswith(suffix) ]

    return(files_list)

def get_barcode_dictionaries(files_list):
    """
    Create a dictionary that has as keys the barcodes associated with the files listed in the 'files_list'
        
    Params
        files_list: List of the absolute path of the files 
        
    Return
        dictionary with as keys 'barcode[0-9]' and values the absolute path of the files  
    """

    barcode_dict = {}

    for file in files_list: 
        barcode = re.search(r"barcode\d+", file).group()
        barcode_dict[barcode] = file

    return(barcode_dict)



if __name__ == "__main__":  
    out_dir = sys.argv[1]
    annotated_dir = sys.argv[2]
    phased_dir = sys.argv[3]

    annotated_suffix = ".annotated.tab.gz"
    phased_suffix = ".phased.vcf.gz"
    merged_suffix = ".annotated_phased.tab"

    print("OUTPUT DIRECTORY:", out_dir)
    print("DIRECTORY annotated files:", annotated_dir)
    print("DIRECTORY phased files:", phased_dir)

    # get list of annotated.tab and phased.vcf files
    annotated_files = get_files_list(annotated_dir, annotated_suffix) 
    phased_files =get_files_list(phased_dir, phased_suffix) 

    # create dictionaries    
    annotated_dict = get_barcode_dictionaries(annotated_files)
    phased_dict = get_barcode_dictionaries(phased_files)

    # check that each barcode has both a annotated.tab and phased.vcf
    if not annotated_dict.keys() == phased_dict.keys():
        print("'barcode[0-9]", annotated_suffix , "' files does not have all a respective 'barcode[0-9]", phased_suffix , "'\n")
        exit(1)

    # create the merged file for all barcodes 
    for barcode in annotated_dict.keys(): 
        filename = barcode + merged_suffix
        merged_file = os.path.join(out_dir, filename)
        print("creazione del file per il ", barcode)

        merge_annotation_phased(
            phased_dict[barcode],
            annotated_dict[barcode],
            merged_file
        )

    # printed only if the pipeline arrive until the end 
    print("Files created successfully")
