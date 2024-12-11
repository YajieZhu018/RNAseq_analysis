# Scripts for RNA-seq analysis of differential gene expression, splicing and isoform switching.
## desep2/
Scripts for analyzing differential gene expression, including quality control of fastq files, star mapping, htseq counting, ruvseq normalization and deseq2.
Basic rules:
Run the python files to write input, output path, and other parameters in text files before submitting the corresponding .sbatch file.
```bash
python run*.py
```
Submit jobs with
```bash
sbatch *.sbatch
```
Common variables:
il: input folder
ol: output folder
fl: script folder

## whippet
Scripts for analyzing RNA splicing, wrapped with snakemake
Basic rules:
Modify config.yaml
Submit jobs with 
```bash
sbatch snakemake.sbatch
```

## isoformswitch
Scripts for analyzing isoform switching events, including salmon quantification.

