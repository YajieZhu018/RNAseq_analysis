#!/bin/bash

#SBATCH -p medium
#SBATCH --job-name=whippet
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/04_Whippet/ICM_CTCF_control/whippet_%A_%a.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/04_Whippet/ICM_CTCF_control/whippet_%A_%a.err
# #SBATCH -c 8
# #SBATCH --nodes=1
# #SBATCH --mem=32gb
#SBATCH --time=36:00:00
# #SBATCH --array=1-4

cd /usr/users/yzhu1/www/0vF36w1M7UjV/Basic_scripts/whippet/
snakemake -s Snakefile -j 100  --latency-wait 10 --cluster "sbatch -p medium -c 8 -N 1 --mem=100gb -t 36:00:00"
# move slurm log files into the output directory
mv ~/www/0vF36w1M7UjV/Basic_scripts/whippet/slurm-*.out ~/www/0vF36w1M7UjV/HMGB2/Analysis/04_Whippet/ICM_CTCF_control/logs/
