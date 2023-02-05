# Map cpg on promoter region
#Note: The gene may have the overlap region of promoters by some reasons, there for, here is a way to fix it for overlap promoter
reference="."
cpg="${reference}/cpg_reference/cpg_hg38/reference_bed/HM450.hg38.bed"
promoter="${reference}/gene_reference/gene_hg38/reference_bed/hg38.v39.promoter_genes.bed"
output_name="450k.hg38.v39"
cd $reference

mkdir -p cpg_gene

bedtools map -a ${cpg} -b ${promoter} -c 4 -o distinct|awk '{if($5!=".") print $0}' > cpg_genemerged_cpg_gene.bed