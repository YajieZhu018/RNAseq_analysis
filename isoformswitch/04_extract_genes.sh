#/bin/bash
# extract gene names of isoform switching from part2 RData
il=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siCTCF_dIF0.1/
ol=/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siCTCF_dIF0.1/02_visualization/
scripts=/usr/users/yzhu1/www/0vF36w1M7UjV/Basic_scripts/isoformswitch/extract_genes.R
cd /usr/users/yzhu1/www/0vF36w1M7UjV/Basic_scripts/isoformswitch/
Rscript $scripts $il
for cond in siCTCF
do 
  awk -v cond=$cond 'BEGIN {OFS=FS="\t"} NR>1 {if ($5==cond && $9=="TRUE") print $3}' "$ol"isoformFeatures.txt | sort -u > "$ol"genes_"$cond".txt
done