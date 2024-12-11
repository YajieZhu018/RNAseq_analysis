#!/usr/bin/bash
il=$1
signalp -fasta "$il"/fasta/isoformSwitchAnalyzeR_isoform_AA_complete.fasta \
  -org euk -format short \
  -prefix "$il"signalip/isoformSwitchInput
