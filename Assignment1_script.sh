#!/bin/bash
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
