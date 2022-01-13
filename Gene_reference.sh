# Section B. Gene's reference postions by chromosome
# Install tool for input and output to the same file without truncating it
# sudo apt-get install moreutils

echo $HOME # visual your home dir
reference="${HOME}/Desktop/CommonData/Epigenetics-and-genetics-references/Gene_reference"
# hg38
mkdir -p $reference/Gene_hg38/reference_gz
mkdir -p $reference/Gene_hg38/reference_bed
# hg19
mkdir -p $reference/Gene_hg19/reference_gz
mkdir -p $reference/Gene_hg19/reference_bed
cd $reference
# Lastest version hg38 download 
wget http://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_39/gencode.v39.annotation.gtf.gz
# Lastest version hg19 download
wget http://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_19/gencode.v19.annotation.gtf.gz
# Chromosome size for hg38 and hg19
wget https://hgdownload.cse.ucsc.edu/goldenpath/hg38/bigZips/hg38.chrom.sizes
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes
head -24 hg19.chrom.sizes|sort -k1,1 -k2,2n|sponge hg19.chrom.sizes
head -24 hg38.chrom.sizes|sort -k1,1 -k2,2n|sponge hg38.chrom.sizes

# HG19
# transcript 
zcat gencode.v19.annotation.gtf.gz |grep -v "#"|tr -d '";'|awk 'OFS="\t" {if ($3=="transcript" && $14=="protein_coding") print $1,$4,$5,$10,$12,".",$7}'|sort -k1,1 -k2,2n  > hg19.v19.transcripts.bed
# gene 
zcat gencode.v19.annotation.gtf.gz |grep -v "#"|tr -d '";'|awk 'OFS="\t" {if ($3=="gene" && $14=="protein_coding") print $1,$4,$5,$10,$18,".",$7}'|sort -k1,1 -k2,2n > hg19.v19.genes.bed
# gene TSS
zcat gencode.v19.annotation.gtf.gz |grep -v "#"|tr -d '";'|awk 'OFS="\t" {if ($3=="gene" && $14=="protein_coding") {if ($7 == "+") {print $1,$4,$4,$12,$18,".",$7} else {print $1,$5,$5,$12,$18".",$7}}}' | sort -k1,1 -k2,2n > hg19.v19.tss_genes.bed
# gene promoter by 500b+/- center by TSS region, do it by yourself or download at wget https://hgdownload.cse.ucsc.edu/goldenpath/hgXX/bigZips/ for 2k 4k promoter region
bedtools slop -i <( cat hg19.v19.tss_genes.bed|cut -f1-4) -b 500 -g hg19.chrom.sizes |sort -k1,1 -k2,2n > hg19.v19.promoter_genes.bed

# HG38
# transcript 
zcat gencode.v39.annotation.gtf.gz |grep -v "#"|tr -d '";'|awk 'OFS="\t" {if ($3=="transcript" && $14=="protein_coding") print $1,$4,$5,$10,$12,".",$7}'|sort -k1,1 -k2,2n  > hg38.v39.transcripts.bed
# gene 
zcat gencode.v39.annotation.gtf.gz |grep -v "#"|tr -d '";'|awk 'OFS="\t" {if ($3=="gene" && $12=="protein_coding") print $1,$4,$5,$10,$14,".",$7}'|sort -k1,1 -k2,2n > hg38.v39.genes.bed
# gene TSS
zcat gencode.v39.annotation.gtf.gz |grep -v "#"|tr -d '";'|awk 'OFS="\t" {if ($3=="gene" && $12=="protein_coding") {if ($7 == "+") {print $1,$4,$4,$12,$14,".",$7} else {print $1,$5,$5,$12,$14".",$7}}}' | sort -k1,1 -k2,2n > hg38.v39.tss_genes.bed
# gene promoter by 500b+/- center by TSS region, do it by yourself or download at wget https://hgdownload.cse.ucsc.edu/goldenpath/hgXX/bigZips/ for 2k 4k promoter region
bedtools slop -i <( cat hg38.v39.tss_genes.bed|cut -f1-4) -b 500 -g hg38.chrom.sizes |sort -k1,1 -k2,2n > hg38.v39.promoter_genes.bed
# Move file to the arranged directories
mv *19*.gz $reference/Gene_hg19/reference_gz
mv *3*.gz $reference/Gene_hg38/reference_gz
mv *19.* $reference/Gene_hg19/reference_bed
mv *38.* $reference/Gene_hg38/reference_bed