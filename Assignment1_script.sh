#!/bin/bash
#QUESTION 1
#Run fastqc on all .fq files
cd ~/Assignment1/AY21/fastq
echo "Running fastqc on .fq files"
fastqc *.fq

#Create directory for fastqc results
echo "Creating directory for fastqc results and moving the fastqc results to that folder"
mkdir fastqc_results

#Move fastqc results into new directory
grep -lir 'fastqc' * |xargs  mv -t fastqc_results

#Unzip fastqc files 
cd 
cd ~/Assignment1/AY21/fastq/fastqc_results; for filename in *.zip; do unzip $filename; done
rm -f *.zip
