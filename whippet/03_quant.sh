#!/bin/bash
fq1=$1
fq2=$2
index=$3
out=$4
out=${out%.psi.gz}


/usr/users/yzhu1/Install/julia-1.6.0-linux-x86_64/julia-1.6.0/bin/julia /usr/users/yzhu1/Install/Whippet.jl/bin/whippet-quant.jl --index $index -o $out $fq1 $fq2
