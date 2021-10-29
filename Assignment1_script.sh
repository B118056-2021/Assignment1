#!/bin/bash
#QUESTION 5
cd
cd Assignment1/AY21/genome_alignment
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
mv Assignment1/AY21/genome_alignment/*.txt Assignment1/AY21/expression_levels