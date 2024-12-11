#!/usr/bin/bash
#SBATCH -p medium
#SBATCH --job-name=iso2
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/iso2_%A_%a.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/iso2_%A_%a.err
#SBATCH -c 8
#SBATCH --nodes=1
#SBATCH --mem=16gb
#SBATCH --time=12:00:00
#SBATCH --array=1
# scripts folder
fl=/usr/users/yzhu1/www/0vF36w1M7UjV/Basic_scripts/isoformswitch/
cd $fl
# input and output folder
il=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siCTCF_dIF0.1/
# pfam predicting protein domain from the web; leave the email address so you will receive the output in the email and copy it
Rscript "$fl"isoforms_part2.R $il > "$il"02_visualization/statistics.txt
