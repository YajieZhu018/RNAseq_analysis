#!/bin/bash
bam=$1
index=$2
index=${index%.jls}
fa=/usr/users/yzhu1/Genome/hg38/hg38.fa
anno=/usr/users/yzhu1/Genome/hg38/hg38.ncbiRefSeq.filtered.gtf
/usr/users/yzhu1/Install/julia-1.6.0-linux-x86_64/julia-1.6.0/bin/julia /usr/users/yzhu1/Install/Whippet.jl/bin/whippet-index.jl --fasta $fa --gtf $anno --index $index --bam $bam --bam-min-reads 6
