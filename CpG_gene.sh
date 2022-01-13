# Map cpg on promoter region
#Note: The gene may have the overlap region of promoters by some reasons, there for, here is a way to fix it for overlap promoter
reference="${HOME}/Desktop/CommonData/Epigenetics-and-genetics-references"
cpg="${reference}/Cpg_reference/Cpg_hg38/reference_bed/HM450.hg38.bed"
promoter="${reference}/Gene_reference/Gene_hg38/reference_bed/hg38.v39.promoter_genes.bed"
output_name="450k.hg38.v39"
cd $reference

bedtools map -a ${cpg} -b ${promoter} -c 4 -o distinct|awk '{if($5!=".") print $0}' \
|awk 'OFS="\t" {if($6!="") print $1,$2,$3,$4,$6 }' > mediator1.bed

bedtools map -a ${cpg} -b ${promoter} -c 4 -o distinct|awk '{if($5!=".") print $0}' \
|awk 'OFS="\t" {if($6=="") print $1,$2,$3,$4,$5 }' > mediator2.bed
# Fix bug cause some promoter have intersections while enhancers do not
cat mediator2.bed >> mediator3.bed
cat mediator1.bed >> mediator3.bed
cat mediator3.bed|sort|uniq|sort -k1,1 -k2,2n > ${output_name}.bed

rm mediator1.bed
rm mediator2.bed
rm mediator3.bed

mv ${output_name}.bed Examples/