#!/bin/bash
#QUESTION 4
cd
cd Assignment1/AY21
mv TriTrypDB-46_TcongolenseIL3000_2019.bed genome_alignment
cd genome_alignment

for file in $(ls *.bam);
do
     echo "Generating counts data for $file"
     bedtools coverage -a TriTrypDB-46_TcongolenseIL3000_2019.bed -b $file -counts > ${file%.*}.bed
done

# -a is the bed file
# -b is the reads alignment bam file
