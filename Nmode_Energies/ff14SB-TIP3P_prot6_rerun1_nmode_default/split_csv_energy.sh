#!/bin/bash

echo "Processing file $1"

FILE_LENGTH=$(cat $1 | wc -l )
for file in $1;
do
    echo "Processing $file"
    FILE_STEM=$(echo $file | awk -F '.' '{ print $1 }')
    START=$(grep -n "Complex" $file | awk -F ':' '{ print $1 }') 
    END=$(grep -n "Receptor" $file | awk -F ':' '{ print $1 }') 
    sed -n "$((START+1)),$((END-1))p" $file > ${FILE_STEM}_complex.csv
    START=$(grep -n "Receptor" $file | awk -F ':' '{ print $1 }') 
    END=$(grep -n "Ligand" $file | awk -F ':' '{ print $1 }') 
    sed -n "$((START+1)),$((END-1))p" $file > ${FILE_STEM}_receptor.csv
    START=$(grep -n "Ligand" $file | awk -F ':' '{ print $1 }') 
    END=$(grep -n "DELTA" $file | head -1 | awk -F ':' '{ print $1 }') 
    sed -n "$((START+1)),$((END-1))p" $file > ${FILE_STEM}_ligand.csv
    START=$(grep -n "DELTA" $file | head -1 | awk -F ':' '{ print $1 }') 
    END=$FILE_LENGTH
    sed -n "$((START+1)),$((END))p" $file > ${FILE_STEM}_DELTA.csv
done

