#!/bin/bash

#SBATCH -p medium
#SBATCH --job-name=index
#SBATCH --output=/usr/users/yzhu1/Genome/mm39/star_index/index_%A.out
#SBATCH --error=/usr/users/yzhu1/Genome/mm39/star_index/index_%A.err
#SBATCH -c 12
#SBATCH --nodes=1
#SBATCH --mem=64gb
#SBATCH --time=4:00:00
#SBATCH --array=1

#module load star/2.7.3a

# output folder
index=/usr/users/yzhu1/Genome/mm39/star_index/
# fa and gtf files as input
fa=/usr/users/yzhu1/Genome/mm39/mm39.fa
gtf=/usr/users/yzhu1/Genome/mm39/mm39.ncbiRefSeq.gtf

STAR --runThreadN 12 \
--runMode genomeGenerate \
--genomeDir $index \
--genomeFastaFiles $fa \
--sjdbGTFfile $gtf \
--sjdbOverhang 100   # set this number to read length -1; find the read length in fastqc report
