# Section A: CpD sites reference position by chromosome
#1. Making reference cpg
# Create the reference data
reference="cpg_reference"
# hg38
mkdir -p $reference/cpg_hg38/
mkdir -p $reference/cpg_hg38/reference_gz
mkdir -p $reference/cpg_hg38/reference_bed
# hg19
mkdir -p $reference/cpg_hg19/
mkdir -p $reference/cpg_hg19/reference_gz
mkdir -p $reference/cpg_hg19/reference_bed
cd $reference
# Download the reference data for CpG Epic 450k and 27k
wget https://zhouserver.research.chop.edu/InfiniumAnnotation/20180909/EPIC/EPIC.hg38.manifest.tsv.gz
wget https://zhouserver.research.chop.edu/InfiniumAnnotation/20180909/HM450/HM450.hg38.manifest.tsv.gz
wget https://zhouserver.research.chop.edu/InfiniumAnnotation/20180909/HM27/HM27.hg38.manifest.tsv.gz
wget https://zhouserver.research.chop.edu/InfiniumAnnotation/20180909/EPIC/EPIC.hg19.manifest.tsv.gz
wget https://zhouserver.research.chop.edu/InfiniumAnnotation/20180909/HM450/HM450.hg19.manifest.tsv.gz
wget https://zhouserver.research.chop.edu/InfiniumAnnotation/20180909/HM27/HM27.hg19.manifest.tsv.gz

# Get the annotation for each kind of methylation array
for i in *.gz
do 
k=`basename $i .manifest.tsv.gz`
zcat $i|sed "1d"|cut -f1,2,3,5|awk 'OFS="\t" {if($1!="NA") print $0}'| sort -k1,1 -k2,2n > ${k}.bed
cat ${k}.bed|awk -v k=$k '{print $0 >> k"_"$1".tsv"}'
echo "Done for $k"
done


for i in *.gz
do 
k=`basename $i .bed`
cat ${k}.bed|awk -v k=$k '{print $0 >> k"_"$1".tsv"}'
echo "Done for $k"
done

mv *hg38*.gz cpg_hg38/reference_gz/
mv *hg19*.gz cpg_hg19/reference_gz/

# Loop to move files
for i in HM27 HM450 EPIC
do
for k in hg19 hg38
do
echo $i.$k
mkdir -p cpg_$k/reference_bed/$i/ ; mv *$i"."$k"_chr"* $_ 
mv $i.$k.bed cpg_$k/reference_bed/
done
done