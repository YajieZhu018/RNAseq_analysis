#!/bin/bash

#SBATCH -p medium
#SBATCH --job-name=fastqc
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Data/Fastq/FastQC/qc_%A_%a.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Data/Fastq/FastQC/qc_%A_%a.err
#SBATCH -c 6
#SBATCH --nodes=1
#SBATCH --mem=16gb
#SBATCH --time=8:00:00
# #SBATCH --array=2-29

#module load fastqc/0.11.4

#Program location

# Input
#inputFileName="/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Scripts/1_STAR/input/"${SLURM_ARRAY_TASK_ID}"_map.txt"

#read1=`sed '1q;d' $inputFileName`
# output folder
ol="/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Data/Fastq/FastQC/siCTCF/"
# run fastqc with all the fastq files as input
fastqc -o $ol -t 6 /usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Data/Fastq/*fastq.gz
# -t: num of processes
# optional: run "multiqc ." in the output folder to get a summary of all reports