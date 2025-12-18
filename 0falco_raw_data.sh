#!/bin/bash

if [ ! -d ./Falco_raw ]
then

mkdir -p Falco_raw/

fi

for fastq in *fastq.gz
do

falco "$fastq" -o ./Falco_raw/"$fastq"_falco_raw/

done