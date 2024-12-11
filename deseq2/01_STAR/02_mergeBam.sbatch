#!/bin/bash

#SBATCH -p medium
#SBATCH --job-name=mb
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Analysis/01_Align/EJC/mb_%A_%a.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Analysis/01_Align/EJC/mb_%A_%a.err
#SBATCH -c 6
#SBATCH --nodes=1
#SBATCH --mem=16gb
#SBATCH --time=2:00:00
#SBATCH --array=1-9

#module load samtools/1.9
# merge replicates
# Input
inputFileName="/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Scripts/01_STAR/input/"${SLURM_ARRAY_TASK_ID}"_mb.txt"
# merged bam
outBam=`sed '1q;d' $inputFileName`
# input bam files
inBam=`sed '2q;d' $inputFileName`

# merge bam
samtools merge $outBam $inBam -@ 5
# index the merged bam
samtools index $outBam
