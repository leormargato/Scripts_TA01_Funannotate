#!/bin/bash
#Script para realizar o corte de adaptadores com Cutadapt, 
#Execute-o dentro da pasta onde estão localizados os arquivos brutos do sequenciamento .fastq.gz

if [ ! -d "Trimmed_fastq" ]; then

    mkdir -p Trimmed_fastq

fi

echo "Realizando a etapa de trimmagem com CutAdapt"

for Pair1 in *_R1_001.fastq.gz
do

Pair2=`echo "$Pair1" | sed "s/_R1/_R2/g"`
output=`basename "$Pair1" _R1_001.fastq.gz`
echo "Trimming $Pair1 and $Pair2"

#Primers for Illumina TruSeq
#PE1: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA
#PE2: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT

#-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA: Specifies the adapter sequence to be trimmed from the 3' end of the first read in each pair.
#-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT: Specifies the adapter sequence to be trimmed from the 3' end of the second read in each pair.
#-u 1 -U 1: Trims one base from the 5' end of both reads.
#-m 50: Discards reads that are shorter than 50 bases after trimming.
#--max-n 0: Discards reads that contain any 'N' bases after trimming.
#-q 30,30: Trims low-quality bases from the ends of each read, with a quality threshold of 30 for both reads.
#-j 4: Uses 4 CPU cores for parallel processing.
#--poly-a: Trims poly-A tails from the reads.


cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-u 1 -U 1 -m 50 --max-n 0 -q 30,30 -j 4 --poly-a \
-o ./Trimmed_fastq/"$output"_R1_cut.fastq.gz \
-p ./Trimmed_fastq/"$output"_R2_cut.fastq.gz ./"$Pair1" \
./"$Pair2" > ./Trimmed_fastq/"$output"_summary.txt

if [ ! -d ../Trimmed_fastq/"$output"_cutadapt ]; then

    mkdir -p ./Trimmed_fastq/"$output"_cutadapt

fi

mv ./Trimmed_fastq/"$output"_R1_cut.fastq.gz ./Trimmed_fastq/"$output"_cutadapt
mv ./Trimmed_fastq/"$output"_R2_cut.fastq.gz ./Trimmed_fastq/"$output"_cutadapt
mv ./Trimmed_fastq/"$output"_summary.txt ./Trimmed_fastq/"$output"_cutadapt
done

echo "Trimmagem finalizada"
echo "Os resultados estão disponíveis na pasta ../Trimmed_fastq/"