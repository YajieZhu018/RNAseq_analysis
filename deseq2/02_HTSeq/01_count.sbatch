#!/bin/bash

#SBATCH -p medium
#SBATCH --job-name=count
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/02_Count/count_%A_%a.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/02_Count/count_%A_%a.err
#SBATCH -c 8
#SBATCH --nodes=1
#SBATCH --mem=32gb
#SBATCH --time=16:00:00
#SBATCH --array=1-8

# activate the conda environment where you installed htseq-count
#conda activate my_root1
# path to the gtf file; you can download the most updated one from ncbi
gtf=/usr/users/yzhu1/Genome/hg38/hg38.ncbiRefSeq.gtf

# Input
inputFileName="/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Scripts/02_HTSeq/input/"${SLURM_ARRAY_TASK_ID}"_count.txt"

bam=`sed '1q;d' $inputFileName`
out=`sed '2q;d' $inputFileName`
feature="exon"
strand="reverse"  #yes (forward-reverse),no,reverse (reserve-forward); indicated by 01_STAR/03_infer_strand.sh


# count features
htseq-count --max-reads-in-buffer 120000000  --additional-attr gene_name -n 8 -f bam -s $strand -r pos -t $feature -m union $bam $gtf > $out
