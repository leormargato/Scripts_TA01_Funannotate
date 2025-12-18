#!/bin/bash

cd ../../Data/

if [ ! -d ./Falco_raw ]
then

mkdir -p Falco_raw/

fi

cd ./Raw/

for fastq in *fastq.gz
do

falco "$fastq" -o ../Falco_raw/"$fastq"_falco_raw/


##fastqc "$fastq" -o ../FastQC_raw/

done
