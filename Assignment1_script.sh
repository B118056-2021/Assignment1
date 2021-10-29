#!/bin/bash
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