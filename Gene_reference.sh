#!/bin/bash
# Creates a sorted BED file with all transcript TSS locations with the Ensembl transcript id for the name column
# This script does this for the Mouse vM19 annotaions, but should work just fine with Human GTF as well

# wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_19/gencode.v19.annotation.gtf.gz
# Encode ID transcript
zcat gencode.v19.annotation.gtf.gz | awk 'OFS="\t" {if ($3=="transcript") {if ($7 == "+") {print $1,$4,$4,$12,".",$7} else {print $1,$5,$5,$12,".",$7}}}' | tr -d '";' | sort -k1,1V -k2,2n > gencode.v19.annotation.tss.bed
# Gene name
zcat gencode.v19.annotation.gtf.gz | awk 'OFS="\t" {if ($3=="transcript") {if ($7 == "+") {print $1,$4,$4,$18,".",$7} else {print $1,$5,$5,$18,".",$7}}}' | tr -d '";' | sort -k1,1V -k2,2n > gencode.v19.annotation.tss.bed
# Combination
zcat gencode.v19.annotation.gtf.gz |tr -d '";' |awk 'OFS="\t" {if ($3=="gene" && $14=="protein_coding" ) {if ($7 == "+") {print $1,$4,$18} else {print $1,$5,$18}}}' |  sort -k1,1V -k2,2n > bengi.tss
#Hg38
# zcat gencode.v19.annotation.gtf.gz |tr -d '";' |awk 'OFS="\t" {if ($3=="gene" && $14=="protein_coding" )
zcat gencode.v38.annotation.gtf.gz|tr -d '";' |awk 'OFS="\t" {if ($3=="gene" && $12=="protein_coding" ) print $14,$10}'|sort -k1,1 -k2,2n > hg38.txt

# Up
bedtools flank -i gencode.v19.annotation.tss.bed -g hg19.chrom.szcat gencode.v38.annotation.gtf.gz|tr -d '";' |awk 'OFS="\t" {if ($3=="gene" && $12=="protein_coding" ) print $1,$4,$5,$14,0,$7}'|sort -k1,1 -k2,2nizes.txt -l 2000 -r 0 -s > genes.2kb.promoters.bed
# Both sides
bedtools flank -i gencode.v19.annotation.tss.bed -g hg19.chrom.sizes.txt -l 2000 -r 0 -s > genes.2kb.promoters.bed
bedtools flank -i GeneList.bed -g hg19.chrom.sizes.txt -l 10 -r 0 -s|sort -k 1,1 -k2,2n >dmm.bed

cat GeneList.TSS1kb.bed| awk 'OFS="\t" {if ($6=="+"){print $1,$2,$4} else {print $1,$3,$4}}'| sort -k1,1V -k2,2n > TSS.hg19.txt
zcat
awk 'NR==FNR {m[$1]=$1; next} {$1=m[$1]; print}' TSS.hg19.txt 25%_high_all.csv


awk 'OFS="," {if ($1=="transcript") {if ($7 == "+") {print $1,$4-1,$4,$12,".",$7} else {print $1,$5-1,$5,$12,".",$7}}}' | tr -d '";' | sort -k1,1V -k2,2n > gencode.v19.annotation.tss.bed

sort -k4,4 | groupBy -g 1,4 -c 4,2,3 -o count,min,max| awk -v OFS='\t' '{print $1, $4, $5, $2, $3}'


for i in  `find *.gz`
do
zcat $i |tr -d '";' |awk 'OFS="\t" {if ($3=="transcript") print $14}'|sort|uniq -c > ${i}.txt
done


zcat gencode.v19.annotation.gtf.gz | awk 'OFS="\t" {if ($3=="gene") {if ($7 == "+") {print $1,$4-100,$4+100,$18,".",$7} else {print $1,$5-100,$5+100,$18,".",$7}}' | tr -d '";' | sort -k1,1V -k2,2n > gencode.v19.annotation.tss.bed