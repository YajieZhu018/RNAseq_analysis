## load packrat env
packrat::init("~/www/0vF36w1M7UjV/Basic_scripts/isoformswitch/")

## ---- results = "hide", message = FALSE, warning=FALSE------------------------
library(IsoformSwitchAnalyzeR)
#library("BSgenome.Hsapiens.UCSC.hg38")

## -----------------------------------------------------------------------------
#packageVersion('IsoformSwitchAnalyzeR')

## -----------------------------------------------------------------------------
### Please note
# The way of importing files in the following example with
# "system.file('pathToFile', package="IsoformSwitchAnalyzeR") is
# specialized way of accessing the example data in the IsoformSwitchAnalyzeR package
# and not something  you need to do - just supply the string e.g.
# parentDir = "/path/to/myQuantifications/" pointing to the parent directory (where
# each sample is a separate sub-directory) to the function.

# input folder
args = commandArgs(trailingOnly=TRUE)
il <- args[1]
cond1_string <- args[2] # control
cond2_string <- args[3]  # treatment
dIF_cutoff <- as.numeric(args[4])
# read conds into list
cond1 <- strsplit(cond1_string, ",")[[1]]
cond2 <- strsplit(cond2_string, ",")[[1]]
#il <- "/usr/users/yzhu1/www/0vF36w1M7UjV/Adi/Analysis/03_IsoformSwitch/"
### Import quantifications
Quant <- importIsoformExpression(parentDir=paste0(il, "01_salmon/"))


## -----------------------------------------------------------------------------
#summary(Quant$abundance)

#head(Quant$counts, 20)

## -----------------------------------------------------------------------------
myDesign <- data.frame(
  sampleID = colnames(Quant$abundance)[-1],
  condition = gsub('_Rep.', '', colnames(Quant$abundance)[-1])
  #libType = c( "forward", "reverse",  "reverse","reverse",  "reverse","reverse") #v1.3KO
  #libType = c( "forward", "reverse",  "reverse", "forward", "forward", "forward", "forward" )
  #libType = c( "forward", "reverse",  "reverse","reverse",  "reverse","reverse","forward", "forward", "forward", "forward" )
)
#myDesign

condToCompare <- data.frame(
  condition_1 = cond1,
  condition_2 = cond2
)

#condToCompare
## ---- message = TRUE, warning=FALSE-------------------------------------------
### Please note:
# The way of importing files in the following example with
# "system.file("extdata/example.gtf.gz", package="IsoformSwitchAnalyzeR")"" is
# specialiced way of accessing the example data in the IsoformSwitchAnalyzeR package
# and not somhting you need to do - just supply the string e.g.
# isoformExonAnnoation="/myAnnotation/myQuantified.gtf" to the isoformExonAnnoation argument

### Create switchAnalyzeRlist
# pair that fasta file with the GTF file witch also contains haplotypes (named: .chr_patch_hapl_scaff.gtf)
mySwitchList <- importRdata(
  isoformCountMatrix   = Quant$counts,
  isoformRepExpression = Quant$abundance,
  designMatrix         = myDesign,
  isoformExonAnnoation = '/usr/users/yzhu1/Genome/hg38/Homo_sapiens.GRCh38.104.chr_patch_hapl_scaff.gtf.gz',
  isoformNtFasta       = '/usr/users/yzhu1/Genome/hg38/Homo_sapiens.GRCh38.cdna.all.fa.gz', 
  comparisonsToMake    = condToCompare,
  showProgress = FALSE
)
print('before cutoff')
summary(mySwitchList)

# set dIF cutoff
#mySwitchList <- subsetSwitchAnalyzeRlist(
#    switchAnalyzeRlist = mySwitchList,
#    subset = abs(mySwitchList$isoformFeatures$dIF) > 0.3
#)
## -----------------------------------------------------------------------------
print('after cutoff')
summary(mySwitchList)

## ---- results = "hide", message = FALSE, warning=FALSE------------------------
mySwitchList <- isoformSwitchAnalysisPart1(
  switchAnalyzeRlist   = mySwitchList,
  #genomeObject = getBSgenome("BSgenome.Hsapiens.UCSC.hg38"),
  #pathToGTF = '/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Data/Annotation/Homo_sapiens.GRCh38.104.chr_patch_hapl_scaff.gtf.gz',
  pathToOutput = paste0(il,"fasta"),
  outputSequences      = TRUE, # change to TRUE when analyzing your own data
  prepareForWebServers = TRUE  # change to TRUE if you will use webservers for external sequence analysis
)

## -----------------------------------------------------------------------------
extractSwitchSummary(mySwitchList )
save.image(paste0(il, "part1.RData"))