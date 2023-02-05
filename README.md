# Epigenetics-and-genetics-references
## 1. Summary: 
In genomics data, we usually call the variants to find out the position at which the nucleotides were changed on the reference genome. Beside, it assists us to reveal the machenism of how the variants contribute to causality of object (diseases/cases over the control).
For instance, the FOXA1 have variant on the beginning of this gene on promoter region, the FOXA1 is the transcription factor. When it has specific vagrant like that, it may change the expression of FOXA1 or it's function. Therefore, what we need:  
+ gtf file for gene annotation and 
+ methylation annotation

Reference: http://zwdzwd.github.io/InfiniumAnnotation

## 2. Download directly
http://zwdzwd.github.io/InfiniumAnnotation
```
wget https://github.com/zhou-lab/InfiniumAnnotationV1/raw/main/Anno/HM27/HM27.hg38.manifest.gencode.v36.tsv.gz
```
## 3. Limitation:
The fourth column contains more than one genes because serveral genes have the overlapping regions on promoter. Therefore, it will be better if we split them all to each unique row and each row is only have one unique value.
