#!/bin/bash
#QUESTION 2
#Concatenate summary files into one big one
echo "Concatenating fastqc summaries into one file"

cd ~/Assignment1/AY21/fastq/fastqc_results
cat */summary.txt > fastqc_summaries.txt 

#Summary of FastQC
echo "Number of raw sequences that passed one of the variables from fastqc:"
grep -c PASS fastqc_summaries.txt
#777
echo "Number of raw sequences that had WARN for one of the variables from fastqc:"
grep -c WARN fastqc_summaries.txt
#86
echo "Number of raw sequences that failed one of the variables from fastqc:"
grep -c FAIL fastqc_summaries.txt
#37

#Per sequence quality score
awk 'NR % 10 == 2' fastqc_summaries.txt > sequence_quality.txt
echo "Number of raw sequences that passed the sequence quality test:"
grep -c PASS sequence_quality.txt

