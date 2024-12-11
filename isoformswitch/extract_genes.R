library(IsoformSwitchAnalyzeR)
args = commandArgs(trailingOnly=TRUE)
il <- args[1] 
path = paste0(il,'part2.RData')
load(path)
switchAnalyzeRlist <- mySwitchList
columnsToExtract <- c("isoform_id", "gene_ref", "gene_id",
            "condition_1", "condition_2", "dIF", "isoform_switch_q_value",
            "gene_switch_q_value", "switchConsequencesGene")
alpha = 0.05
dIFcutoff = 0.1
dataDF <- switchAnalyzeRlist$isoformFeatures[which(switchAnalyzeRlist$isoformFeatures$isoform_switch_q_value < alpha 
& abs(switchAnalyzeRlist$isoformFeatures$dIF) > dIFcutoff), 
na.omit(match(columnsToExtract, colnames(switchAnalyzeRlist$isoformFeatures)))]
path = paste0(il,"02_visualization/isoformFeatures.txt")
write.table(dataDF,path,sep="\t",col.name=TRUE, row.name=FALSE, quote=FALSE)

