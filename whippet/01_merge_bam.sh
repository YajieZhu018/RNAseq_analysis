#!/bin/bash
module load samtools/1.12
# Input
bam=$1
merged_bam=$2
thread=$3
tl=/scratch1/users/yzhu1/EJC/sortBam/
mkdir -p $tl
temp_bam=/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Analysis/11_AS/01_Whippet/EJC/merged.sorted.bam
#samtools merge -@ $thread "$tl"merged.bam $bam
#samtools sort -@ $thread -o "$tl"merged.sorted.bam "$tl"merged.bam
#samtools rmdup -S "$tl"merged.sorted.bam $merged_bam
samtools rmdup -S $temp_bam $merged_bam
samtools index -@ $thread $merged_bam
