#!/bin/bash

#SBATCH -p medium
#SBATCH --job-name=id
#SBATCH --output=/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Data/Annotation/id_%A_%a.out
#SBATCH --error=/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Data/Annotation/id_%A_%a.err
#SBATCH -c 8
# #SBATCH -C scratch2
#SBATCH --nodes=1
#SBATCH --mem=16gb
#SBATCH --time=4:00:00
# #SBATCH --array=1-3

# generate salmon index for quantification
trans=/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Data/Annotation/Homo_sapiens.GRCh38.cdna.all.fa.gz  # input fa; downloaded from http://ftp.ensembl.org/pub/
index=/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Data/Annotation/hg38_cdna_index  # output folder
salmon index -t $trans -i $index
