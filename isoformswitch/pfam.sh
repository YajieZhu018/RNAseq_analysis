#!/bin/bash
# module load hmm
# Input folder
INPUT_FOLDER=$1
# Input protein sequence in FASTA format
INPUT_SEQ="$INPUT_FOLDER"fasta/isoformSwitchAnalyzeR_isoform_AA_complete.fasta
# Path to Pfam database
PFAM_DB="Pfam-A.hmm"

# pfam index was generated with generate_pfam_index.sbatch
# Output file for domain predictions
OUTPUT_FILE="$INPUT_FOLDER"pfam/pfamtblout_isoformSwitchInput.txt

# Step 2: Run HMMER search
hmmscan --pfamtblout $OUTPUT_FILE --cut_ga --noali $PFAM_DB $INPUT_SEQ 
#--tblout $OUTPUT_FILE -E 1 --domE 1 --incE 0.01 --incdomE 0.03  $PFAM_DB $INPUT_SEQ 