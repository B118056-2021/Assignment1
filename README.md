# RNA-seq-Analysis-using-Bash

Biological background to project:
- RNAseq data generated from a Trypanosoma congolense RNAi experiment in the IL3000 laboratory strain of T. congolense that knocks down a specific gene. As the gene encodes an enzyme that is critical for
energy metabolism
- Hypothesis: loss of function of this enzyme might illuminate other pathways that the parasite might activate to circumvent loss of the "default" pathway.
- Experimental set up:
     - samples taken at T=0h, T=24h and T=48h
     - some of the samples are un-induced, while others have been treated with tetra-cycline to induce gene expression from the RNAi construct
     - 3 different sample types:
        1. Wild type (WT) cultures are Trypanosoma congolense samples without the RNAi construct; there are three replicates of most conditions.
        2. Clone1 is a Trypanosoma congolense cell line that has the RNAi construct in it; there are three replicates of each condition.
        3. Clone2 is another Trypanosoma congolense cell line that has the RNAi construct in it; there are three replicates of each condition.

The pipeline contains the overall design components/modules:
1. perform a quality check on the paired-end raw sequence data using the fastqc
2. assess the numbers and quality of the raw sequence data based on the output of fastqc
3. align the read pairs to the Trypanosoma congolense genome using bowtie2, converting the output to indexed "bam" format with samtools 
4. generate counts data (assumption is that all genes have no introns)
5. generate plain text tab-delimited output files that give the statistical mean (average) of the counts per gene (i.e. expression levels) for each group; as the gene names are pretty
uninformative to a biologist, the gene descriptions (provided in the bed file) should also be included.
6. use the mean expression levels to generate "fold change" data for the "group-wise" comparisons (no statistical testing)

<img src="https://user-images.githubusercontent.com/91611978/170041348-f4b8e153-9e5c-4d55-9d53-672745727904.png" width="600" height="1000">

