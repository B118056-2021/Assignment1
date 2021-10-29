#!/bin/bash
cd
#Create Assignment 1 directory in home directory
echo "Creating Assignment 1 folder"
mkdir Assignment1; cd ~/Assignment1

#Copy AY21 directory into own directory
echo "Copying assignment data into Assignment 1 folder"
cp -r /localdisk/data/BPSM/AY21 .

#Unzip files
echo "Unzipping fastq files"
cd ~/Assignment1/AY21/fastq; for gzip in *.gz; do gzip -d $gzip; done