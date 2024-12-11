# Scripts for RNA-seq analysis of differential gene expression, splicing and isoform switching.
## desep2
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

See more info about the deseq2 package: https://bioconductor.org/packages/release/bioc/html/DESeq2.html

## whippet
Scripts for analyzing RNA splicing, wrapped with snakemake

Basic rules:

Modify config.yaml

Submit jobs with 
```bash
sbatch snakemake.sbatch
```
See more info about whippet: https://github.com/timbitz/Whippet.jl

## isoformswitch
Scripts for analyzing isoform switching events, including salmon quantification.

See more info about the IsoformSwitchAnalyzeR package: https://bioconductor.org/packages/release/bioc/vignettes/IsoformSwitchAnalyzeR/inst/doc/IsoformSwitchAnalyzeR.html

