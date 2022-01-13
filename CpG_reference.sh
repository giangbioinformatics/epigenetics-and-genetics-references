# Section A: CpD sites reference position by chromosome
#1. Making reference cpg
# Create the reference data
echo $HOME # visual your home dir
reference="${HOME}/Desktop/CommonData/Epigenetics-and-genetics-references/Cpg_reference"
# hg38
mkdir -p $reference/Cpg_hg38/
mkdir -p $reference/Cpg_hg38/reference_gz
mkdir -p $reference/Cpg_hg38/reference_bed
# hg19
mkdir -p $reference/Cpg_hg19/
mkdir -p $reference/Cpg_hg19/reference_gz
mkdir -p $reference/Cpg_hg19/reference_bed
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
echo "Done for $k"
done

mv *hg38*.gz Cpg_hg38/reference_gz/
mv *hg19*.gz Cpg_hg19/reference_gz/
mv *hg38.bed Cpg_hg38/reference_bed/
mv *hg19.bed Cpg_hg19/reference_bed/

# Check for annotation
head -5 EPIC.hg38.bed
# chr1    10524   10526   cg14817997
# chr1    10847   10849   cg26928153
# chr1    10849   10851   cg16269199
# chr1    15864   15866   cg13869341
# chr1    18826   18828   cg14008030




