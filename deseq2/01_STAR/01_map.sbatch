#!/bin/bash
#SBATCH -p medium
#SBATCH --job-name=map
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/01_Align/MAP_%A_%a.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/01_Align/MAP_%A_%a.err
#SBATCH -c 10
#SBATCH --nodes=1
#SBATCH --mem=64gb
#SBATCH --time=16:00:00
#SBATCH --array=5-8

#module load star/2.7.3a
#module load samtools/1.12

# path to the index generated with 00_index.sbatch
index=/usr/users/yzhu1/Genome/hg38/star_index_sjdbOverhang149/

# run 01_run.py to get *_map.txt first
inputFileName="/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Scripts/01_STAR/input/"${SLURM_ARRAY_TASK_ID}"_map.txt"
# extract the name of the input fastq file and the output bam file from $inputFileName
read=`sed '1q;d' $inputFileName`
sample=`sed '2q;d' $inputFileName`

# mapping
STAR --runThreadN 12 --genomeDir $index --readFilesIn $read  \
      --outFileNamePrefix $sample --outSAMtype BAM SortedByCoordinate --outWigType bedGraph \
      --readFilesCommand zcat --limitBAMsortRAM 5000000000
# indexing
samtools index "$sample"Aligned.sortedByCoord.out.bam
