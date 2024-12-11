#!/bin/bash

#c1=$1
#c2=$2
#c3=$3
#t1=$4
#t2=$5
#t3=$6
#il=$7
#out=$8
c1=$1
c2=$2
t1=$3
t2=$4
#il=$5
out=$5
out=${out%.sig.diff.txt}

#cd $il
/usr/users/yzhu1/Install/julia-1.6.0-linux-x86_64/julia-1.6.0/bin/julia /usr/users/yzhu1/Install/Whippet.jl/bin/whippet-delta.jl \
   -a $t1,$t2 -b $c1,$c2 -o $out

# unzip 
gzip -d "$out".diff.gz  
awk 'BEGIN {OFS=FS="\t"}
  NR==1 {print; next}
  ($8 > 0.1 || $8 < -0.1) && $9 > 0.9 {print}' "$out".diff > "$out".sig.diff.txt