#!/bin/bash

#SBATCH -p medium
#SBATCH --job-name=qm
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/01_Align/infer_strand.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/01_Align/infer_strand.err
#SBATCH -C scratch2
#SBATCH -c 1
#SBATCH --nodes=1
#SBATCH --mem=8gb
#SBATCH --time=2:00:00
#SBATCH --array=1-4

# get the strandness, which is requested as a parameter in htseq count
#module load rseqc/2.6.3
# reference genome as a bed file
ref=ref_hg38.bed  # modify it as the absolute full path
for cond in SP_1 SP_2 SP_3 SP_4
do
  echo $cond
  infer_experiment.py -r $ref -i ~/www/0vF36w1M7UjV/HMGB2/Analysis/01_Align/"$cond"/Aligned.sortedByCoord.out.bam  # it will indicate its strandness
done
