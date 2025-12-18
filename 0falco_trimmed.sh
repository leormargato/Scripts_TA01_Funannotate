#!/bin/bash

if [ ! -d ./Falco_trimmed ]
then

mkdir -p Falco_trimmed/

fi

for fastq in *fastq.gz
do

falco "$fastq" -o ../Falco_trimmed/"$fastq"_falco_trimmed/


##fastqc "$fastq" -o ../FastQC_raw/

done