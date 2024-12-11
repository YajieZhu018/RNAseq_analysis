#!/usr/bin/bash
#SBATCH -p medium
#SBATCH --job-name=iso1
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siCTCF_dIF0.1/iso1_%A_%a.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siCTCF_dIF0.1/iso1_%A_%a.err
#SBATCH -c 8
#SBATCH --nodes=1
#SBATCH --mem=16gb
#SBATCH --time=12:00:00
#SBATCH --array=1

# run part1 and get the required input for part2
# scripts folder
fl=/usr/users/yzhu1/www/0vF36w1M7UjV/Basic_scripts/isoformswitch/
cd $fl
# input and output folder
il=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siCTCF_dIF0.1/
ln -s /usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/01_salmon/ "$il"
mkdir "$il"fasta
dIF_cutoff=0.1
Rscript "$fl"isoforms_part1.R $il CTCFcontrol siCTCF $dIF_cutoff
# input and output folder
mkdir "$il"cpat "$il"iupred2a "$il"signalip "$il"pfam "$il"02_visualization
# coding potential
bash cpat.sh $il
# IDR
bash iupred2a.sh $il
# signal peptide
bash signaip.sh $il
# run pfam on the web: https://www.ebi.ac.uk/Tools/hmmer/search/hmmscan
