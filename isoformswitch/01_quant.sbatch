#!/bin/bash

#SBATCH -p medium
#SBATCH --job-name=qt
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/Adi/Analysis/03_IsoformSwitch/01_salmon/qt_%A_%a.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/Adi/Analysis/03_IsoformSwitch/01_salmon/qt_%A_%a.err
#SBATCH -c 8
#SBATCH --nodes=1
#SBATCH --mem=16gb
#SBATCH --time=8:00:00
#SBATCH --array=1-9


# Input
inputFileName="/usr/users/yzhu1/www/0vF36w1M7UjV/Adi/Scripts/03_IsoformSwitch/input/"${SLURM_ARRAY_TASK_ID}"_qt.txt"

# path to the fastq files
f1=`sed '1q;d' $inputFileName`  # this is a single-end sequencing example; add f2 for paired-end
out=`sed '2q;d' $inputFileName`
index=/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Data/Annotation/hg38_cdna_index  # run salmon index first

salmon quant -i $index -l A \
         -r $f1 \
         -p 8 --validateMappings -o $out 
# -l A: to decide library size automatically
# -r $read1 for single-end; -1 $read1 -2 $read2 for paired-end
