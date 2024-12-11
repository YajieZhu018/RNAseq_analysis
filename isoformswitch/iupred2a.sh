#!/bin/bash
il=$1
mkdir "$il"fasta/temp/
cd "$il"fasta
# split fasta into files that each file only contains each aa
awk 'BEGIN {RS=">"} NR>1 {print ">"$0 >"temp/"(NR-1)".txt"}' isoformSwitchAnalyzeR_isoform_AA_complete.fasta
for file in temp/*
do
  head -n 1 $file >> "$il"/iupred2a/isoformSwitchInput.txt
  python3 /usr/users/yzhu1/Install/iupred2a/iupred2a.py -a $file long >> "$il"/iupred2a/isoformSwitchInput.txt
done
cd  ~/www/0vF36w1M7UjV/Adi/Scripts/03_IsoformSwitch/
# -a enable anchor2 prediction
