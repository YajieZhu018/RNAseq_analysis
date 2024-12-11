#!/usr/bin/bash
# since the input is fasta, the human genome version doesn't matter.
il=$1
cpat.py -g "$il"fasta/isoformSwitchAnalyzeR_isoform_nt.fasta \
  -o "$il"cpat/cpat \
  -d /usr/users/yzhu1/www/0vF36w1M7UjV/RS/Data/CPAT/Human_logitModel.RData \
  -x /usr/users/yzhu1/www/0vF36w1M7UjV/RS/Data/CPAT/Human_Hexamer.tsv

# format *ORF_prob.best.tsv into isoformswitch input and label prob > 0.364 as yes in Coding Label
awk 'BEGIN {OFS=FS="\t"; print "Data ID","Sequence Name","RNA size","ORF size", "Ficket Score", "Hexamer Score","Coding Probability", "Coding Label"}
  NR > 1 {print NR-2, $1, $3, $8, $9, $10, $11, ($11>0.364)?"yes":"no"}' "$il"cpat/cpat.ORF_prob.best.tsv > "$il"cpat/isoformSwitchInput.txt
