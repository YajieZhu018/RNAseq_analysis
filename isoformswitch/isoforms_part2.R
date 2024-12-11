

## ---- results = "hide", message = FALSE, warning=FALSE------------------------
library(IsoformSwitchAnalyzeR)
#library("BSgenome.Hsapiens.UCSC.hg38")
# input
args = commandArgs(trailingOnly=TRUE)
il <- args[1]
load(paste0(il, "part1.RData"))

## -----------------------------------------------------------------------------
# Please note that in the following the part of the examples using
# the "system.file()" command not nesseary when using your own
# data - just supply the path as a string
# (e.g. pathToCPC2resultFile = "/myFiles/myCPC2results.txt" )

mySwitchList <- isoformSwitchAnalysisPart2(
  switchAnalyzeRlist        = mySwitchList,
  codingCutoff              = 0.725, 
  n                         = 30,    # if plotting was enabled, it would only output the top 10 switches
  pathToPFAMresultFile      = paste0(il, "pfam/isoformSwitchInput.txt"),
  pathToIUPred2AresultFile  = paste0(il, "iupred2a/isoformSwitchInput.txt"),
  pathToSignalPresultFile   = paste0(il, "signalip/isoformSwitchInput_summary.signalp5"),
  pathToCPATresultFile      = paste0(il, "cpat/isoformSwitchInput.txt"),
  removeNoncodinORFs        = TRUE,  # TRUE if ORF was predicted de novo
  pathToOutput              = paste0(il, "02_visualization/"),
  outputPlots               = TRUE  # keeps the function from outputting the plots from this example
)
# save it
save.image(paste0(il, "part2.RData"))
# load the image
#load(paste0(il, "part2.RData"))
## plots
#pdf(file = paste0(il,"02_visualization/01_switchOverlap.pdf"), onefile = FALSE, height=6, width = 9)
#extractSwitchOverlap(
#  mySwitchList,
#  filterForConsequences=TRUE,
#  plotIsoforms = FALSE
#)
#dev.off()


pdf(file = paste0(il,"02_visualization/02_consequenceSummary.pdf"), onefile = FALSE, height=6, width = 9)
extractConsequenceSummary(
  mySwitchList,
  consequencesToAnalyze='all',
  plotGenes = FALSE,           # enables analysis of genes (instead of isoforms)
  asFractionTotal = FALSE      # enables analysis of fraction of significant features
)
dev.off()

pdf(file = paste0(il,"02_visualization/03_consequenceEnrichment.pdf"), onefile = FALSE, height=6, width = 9)
extractConsequenceEnrichment(
  mySwitchList,
  consequencesToAnalyze='all',
  analysisOppositeConsequence = TRUE,
  returnResult = TRUE # if TRUE returns a data.frame with the summary statistics
)
dev.off()

pdf(file = paste0(il,"02_visualization/04_splicingEnrichment.pdf"), onefile = FALSE, height=6, width = 9)
extractSplicingEnrichment(
  mySwitchList,
  returnResult = TRUE # if TRUE returns a data.frame with the summary statistics
)
dev.off()

pdf(file = paste0(il,"02_visualization/05_qvalue_dIF_volcano.pdf"), onefile = FALSE, height=6, width = 9)
ggplot(data=mySwitchList$isoformFeatures, aes(x=dIF, y=-log10(isoform_switch_q_value))) +
  geom_point(
    aes( color=abs(dIF) > 0.1 & isoform_switch_q_value < 0.05 ), # default cutoff
    size=1
  ) +
  geom_hline(yintercept = -log10(0.05), linetype='dashed') + # default cutoff
  geom_vline(xintercept = c(-0.1, 0.1), linetype='dashed') + # default cutoff
  facet_wrap( ~ condition_2) +
  #facet_grid(condition_1 ~ condition_2) + # alternative to facet_wrap if you have overlapping conditions
  scale_color_manual('Signficant\nIsoform Switch', values = c('black','red')) +
  labs(x='dIF', y='-Log10 ( Isoform Switch Q Value )') +
  theme_bw()
dev.off()

pdf(file = paste0(il,"02_visualization/06_dIF_fc_volcano.pdf"), onefile = FALSE, height=6, width = 9)
ggplot(data=mySwitchList$isoformFeatures, aes(x=gene_log2_fold_change, y=dIF)) +
  geom_point(
    aes( color=abs(dIF) > 0.1 & isoform_switch_q_value < 0.05 ), # default cutoff
    size=1
  ) + 
  facet_wrap(~ condition_2) +
  #facet_grid(condition_1 ~ condition_2) + # alternative to facet_wrap if you have overlapping conditions
  geom_hline(yintercept = 0, linetype='dashed') +
  geom_vline(xintercept = 0, linetype='dashed') +
  scale_color_manual('Signficant\nIsoform Switch', values = c('black','red')) +
  labs(x='Gene log2 fold change', y='dIF') +
  theme_bw()
dev.off()