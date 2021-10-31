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


#QUESTION 3
#Move to Tcongo_genome directory
cd
cd ~/Assignment1/AY21/Tcongo_genome; for gzip in *.gz; do gzip -d $gzip; done

#Make database for bowtie2
echo "Building Tcongolense_genome_database from its fasta file"
bowtie2-build TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta Tcongolense_genome_database

#Read pairs alignment to T. congolense genome using bowtie2
cd
fqdir=Assignment1/AY21/fastq
for x1 in "$fqdir"/*_1.fq; do
    x2=${x1%_1.fq}_2.fq
    if [[ -f $x2 ]] ; then
        echo "Aligning $x1 and $x2 to Tcongolense_genome_database"
        bowtie2 --threads 60 -x ~/Assignment1/AY21/Tcongo_genome/Tcongolense_genome_database -1 "$x1" -2 "$x2" -S "${x1%.*}"_output.sam
    else
        echo "$x2 not found" >&2
    fi
done

cd; mkdir Assignment1/AY21/genome_alignment
mv  Assignment1/AY21/fastq/*.sam Assignment1/AY21/genome_alignment

cd; cd Assignment1/AY21/genome_alignment

#Convert output to indexed "bam" format with samtools
for file in $(ls *.sam);
do
    # ${file%.*} means that it will take the file name and remove everything
    # after the last punctuation in the name. 
    echo "Converting $file to ${file%.*}.bam"
    samtools view -bS $file > ${file%.*}.bam
done

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

mkdir sam_files; mv *.sam bam_files
mkdir bam_files; mv *.bam bam_files
mkdir bed_files; mv *.bed bed_files


#QUESTION 5
cd
cd Assignment1/AY21/genome_alignment/bed_files
#Group 1 - WT: t=0, Uninduced
echo "Generating text file with mean of the counts per gene for WT, t=0, uninduced: WT_t0_U"
cut -f4,5 100k.WT-1-507_1_output.bed > WT_t0_U.txt
for f in 100k.WT-1-507_1_output.bed 100k.WT-2-511_1_output.bed 100k.WT-3-512_1_output.bed
do
    cut -f6 "$f" | paste WT_t0_U.txt - > tmp.txt
    mv {tmp,WT_t0_U}.txt
done

#Group 2 - WT: t=24, Uninduced
echo "Generating text file with mean of the counts per gene for WT, t=24, Uninduced: WT_t24_U"
cut -f4,5 100k.WT-4-530_1_output.bed > WT_t24_U.txt
for f in 100k.WT-4-530_1_output.bed 100k.WT-5-531_1_output.bed 100k.WT-6-532_1_output.bed
do
    cut -f6 "$f" | paste WT_t24_U.txt - > tmp.txt
    mv {tmp,WT_t24_U}.txt
done

#Group 3 - WT: t=24, Induced
echo "Generating text file with mean of the counts per gene for WT, t=24, Induced: WT_t24_I"
cut -f4,5 100k.WT-1-525_1_output.bed > WT_t24_I.txt
for f in 100k.WT-1-525_1_output.bed 100k.WT-2-526_1_output.bed 100k.WT-3-529_1_output.bed
do
    cut -f6 "$f" | paste WT_t24_I.txt - > tmp.txt
    mv {tmp,WT_t24_I}.txt
done

#Group 4 - WT: t=48, Uninduced
echo "Generating text file with mean of the counts per gene for WT, t=48, Uninduced: WT_t48_U"
cut -f4,5 100k.WT-4-553_1_output.bed > WT_t48_U.txt
for f in 100k.WT-4-553_1_output.bed 100k.WT-5-554_1_output.bed 100k.WT-6-555_1_output.bed
do
    cut -f6 "$f" | paste WT_t48_U.txt - > tmp.txt
    mv {tmp,WT_t48_U}.txt
done
#Group 5 - WT: t=48, Induced
echo "Generating text file with mean of the counts per gene for WT, t=48, Induced: WT_t48_I"
cut -f4,5 100k.WT-1-550_1_output.bed > WT_t48_I.txt
for f in 100k.WT-1-550_1_output.bed 100k.WT-2-551_1_output.bed 100k.WT-3-552_1_output.bed
do
    cut -f6 "$f" | paste WT_t48_I.txt - > tmp.txt
    mv {tmp,WT_t48_I}.txt
done
#Group 6 - Clone 1: t=0, Uninduced
echo "Generating text file with mean of the counts per gene for Clone 1, t=0, Uninduced: C1_t0_U"
cut -f4,5 100k.C1-1-501_1_output.bed > C1_t0_U.txt
for f in 100k.C1-1-501_1_output.bed 100k.C1-2-502_1_output.bed 100k.C1-3-503_1_output.bed
do
    cut -f6 "$f" | paste C1_t0_U.txt - > tmp.txt
    mv {tmp,C1_t0_U}.txt
done
#Group 7 - Clone 1: t=24, Uninduced
echo "Generating text file with mean of the counts per gene for Clone 1, t=24, Uninduced: C1_t24_U"
cut -f4,5 100k.C1-4-516_1_output.bed > C1_t24_U.txt
for f in 100k.C1-4-516_1_output.bed 100k.C1-5-517_1_output.bed 100k.C1-6-518_1_output.bed
do
    cut -f6 "$f" | paste C1_t24_U.txt - > tmp.txt
    mv {tmp,C1_t24_U}.txt
done
#Group 8 - Clone 1: t=24, Induced
echo "Generating text file with mean of the counts per gene for Clone 1, t=24, Induced: C1_t24_I"
cut -f4,5 100k.C1-1-513_1_output.bed > C1_t24_I.txt
for f in 100k.C1-1-513_1_output.bed 100k.C1-2-514_1_output.bed 100k.C1-3-515_1_output.bed
do
    cut -f6 "$f" | paste C1_t24_I.txt - > tmp.txt
    mv {tmp,C1_t24_I}.txt
done
#Group 9 - Clone 1: t=48, Uninduced
echo "Generating text file with mean of the counts per gene for Clone 1, t=48, Uninduced: C1_t48_U"
cut -f4,5 100k.C1-4-536_1_output.bed > C1_t48_U.txt
for f in 100k.C1-4-536_1_output.bed 100k.C1-5-539_1_output.bed 100k.C1-6-541_1_output.bed
do
    cut -f6 "$f" | paste C1_t48_U.txt - > tmp.txt
    mv {tmp,C1_t48_U}.txt
done
#Group 10 - Clone 1: t=48, Induced
echo "Generating text file with mean of the counts per gene for Clone 1, t=48, Uninduced: C1_t48_I"
cut -f4,5 100k.C1-1-533_1_output.bed > C1_t48_I.txt
for f in 100k.C1-1-533_1_output.bed 100k.C1-2-534_1_output.bed 100k.C1-3-535_1_output.bed
do
    cut -f6 "$f" | paste C1_t48_I.txt - > tmp.txt
    mv {tmp,C1_t48_I}.txt
done
#Group 11 - Clone 2: t=0, Uninduced
echo "Generating text file with mean of the counts per gene for Clone 2, t=0, Uninduced: C2_t0_U"
cut -f4,5 100k.C2-1-504_1_output.bed > C2_t0_U.txt
for f in 100k.C2-1-504_1_output.bed 100k.C2-2-505_1_output.bed 100k.C2-3-506_1_output.bed
do
    cut -f6 "$f" | paste C2_t0_U.txt - > tmp.txt
    mv {tmp,C2_t0_U}.txt
done
#Group 12 - Clone 2: t=24, Uninduced
echo "Generating text file with mean of the counts per gene for Clone 2, t=24, Uninduced: C2_t24_U"
cut -f4,5 100k.C2-4-522_1_output.bed > C2_t24_U.txt
for f in 100k.C2-4-522_1_output.bed 100k.C2-5-523_1_output.bed 100k.C2-6-524_1_output.bed
do
    cut -f6 "$f" | paste C2_t24_U.txt - > tmp.txt
    mv {tmp,C2_t24_U}.txt
done
#Group 13 - Clone 2: t=24, Induced
echo "Generating text file with mean of the counts per gene for Clone 2, t=24, Induced: C2_t24_I"
cut -f4,5 100k.C2-1-519_1_output.bed > C2_t24_I.txt
for f in 100k.C2-1-519_1_output.bed 100k.C2-2-520_1_output.bed 100k.C2-3-521_1_output.bed
do
    cut -f6 "$f" | paste C2_t24_I.txt - > tmp.txt
    mv {tmp,C2_t24_I}.txt
done
#Group 14 - Clone 2: t=48, Uninduced
echo "Generating text file with mean of the counts per gene for Clone 2, t=48, Uninduced: C2_t48_U"
cut -f4,5 100k.C2-4-545_1_output.bed > C2_t48_U.txt
for f in 100k.C2-4-545_1_output.bed 100k.C2-5-546_1_output.bed 100k.C2-6-548_1_output.bed
do
    cut -f6 "$f" | paste C2_t48_U.txt - > tmp.txt
    mv {tmp,C2_t48_U}.txt
done
#Group 15 - Clone 2: t=48, Induced
echo "Generating text file with mean of the counts per gene for Clone 2, t=48, Induced: C2_t48_I"
cut -f4,5 100k.C2-1-542_1_output.bed > C2_t48_I.txt
for f in 100k.C2-1-542_1_output.bed 100k.C2-2-543_1_output.bed 100k.C2-3-544_1_output.bed
do
    cut -f6 "$f" | paste C2_t48_I.txt - > tmp.txt
    mv {tmp,C2_t48_I}.txt
done

for file in *_U.txt
do
    awk '{sum = 0; for (i = 0; i <= NF; i++) sum += $i; sum /= 3; print sum}' $file > $file_temp.txt
    cut -f1 $f_temp.txt | paste $file - > tmp.txt
    mv {tmp,${file%.*}}.txt
    rm -f $file_temp.txt
done

for file in *_I.txt
do
    awk '{sum = 0; for (i = 0; i <= NF; i++) sum += $i; sum /= 3; print sum}' $file > $file_temp.txt
    cut -f1 $f_temp.txt | paste $file - > tmp.txt
    mv {tmp,${file%.*}}.txt
    rm -f $file_temp.txt
done


cd
cd Assignment1/AY21
mkdir expression_levels

cd
mv Assignment1/AY21/genome_alignment/bed_files/*.txt Assignment1/AY21/expression_levels

#QUESTION 6
cd
cd Assignment1/AY21
mkdir fold_change

cd
cd Assignment1/AY21/expression_levels
for i in *.txt
do
  for j in *.txt
  do
    if [ "$i" \< "$j" ]
    then
     echo "$i:$j" >> combinations.txt
     echo "$j:$i" >> combinations.txt
    fi
  done
done

awk '!/combinations/' combinations.txt > temp && mv temp combinations.txt
cd
mv Assignment1/AY21/expression_levels/folder/combinations.txt Assignment1/AY21/fold_change

cd
cd Assignment1/AY21/expression_levels
echo "Generating text file with mean of gene counts for all groups"

cut -f1,2 C2_t24_I.txt > means_all_groups.txt
for file in *_U.txt *_I.txt
do
    cut -f6 $file | paste means_all_groups.txt - > tmp.txt
    mv {tmp,means_all_groups}.txt
    rm -f $tmp.txt
done 

cd
mv Assignment1/AY21/expression_levels/means_all_groups.txt Assignment1/AY21/fold_change

cd; cd Assignment1/AY21/fold_change
