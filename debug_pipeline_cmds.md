# Problems with eagle2 
It seems that there are not enough SNPs

```shell 
# Check how many SNPs are in your input VCF
bcftools stats your_input.vcf.gz | grep "number of SNPs"

# Check chromosome naming in your VCF vs the panel
bcftools view -h your_input.vcf.gz | grep "^##contig"
bcftools view -h panel_file.bcf | grep "^##contig"

# Check overlapping sites
bcftools isec -n=2 your_input.vcf.gz panel_file.bcf | wc -l
# Count SNPs per chromosome
bcftools query -f '%CHROM\n' barcode05_merge_output.vcf.gz | sort | uniq -c | sort -rn
```

In the end it was that I have to put only the barcode that have the genes that are in the panel, otherwise that barcodes will give an error. 
