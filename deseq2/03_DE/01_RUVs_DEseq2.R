# I usually run this in gwdg Rstudio
# load library
library(DESeq2)
library(RUVSeq)

# input
m <- 2  #replicates of control
n <- 2  #replicates of treatment

# read csv file
il <- "/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/02_Count/"
ol <- "/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/03_DE/siCTCF/"

inFileName <- paste0(il, "table_count_siCTCF.txt")
count_table <- read.table(inFileName, sep = "\t", header=TRUE, row.names=1)

## ----filter-----------------------------------------------
# filter out those with less than 3 column having counts <=5
filter <- apply(count_table, 1, function(x) length(x[x>5])>=2)
filtered <- count_table[filter,]

## ----store_data-------------------------------------------
x <- as.factor(c(rep("Ctl",m), rep("Trt",n)))
set <- newSeqExpressionSet(as.matrix(filtered),
                           phenoData = data.frame(x, row.names=colnames(filtered)))
set

## ----rle, fig.cap="No normalization.",fig.subcap=c("RLE plot","PCA plot")----
library(RColorBrewer)
colors <- brewer.pal(3, "Set2")


# Try both RUVs and RUVg to see which is better
# RUVs
## ----diff-------------------------------------------------
differences <- makeGroups(x)
differences

## ----ruvs, eval=FALSE-------------------------------------
genes <- rownames(filtered)
sets <- RUVs(set, genes, k=1, differences)
pData(sets)

# plot
plotRLE(sets, outline=FALSE, col=colors[x])
plotPCA(sets, col=colors[x], cex=1,xlim=c(-1,0.8))

# RUVg
## ----ruvg, eval=FALSE-------------------------------------
# get negative control (5000 genes whose expression don't change)
design <- model.matrix(~x, data=pData(set))
y <- DGEList(counts=counts(set), group=x)
y <- calcNormFactors(y, method="upperquartile")
y <- estimateGLMCommonDisp(y, design)
y <- estimateGLMTagwiseDisp(y, design)
fit <- glmFit(y, design)
lrt <- glmLRT(fit, coef=2)
top <- topTags(lrt, n=nrow(set))$table
empirical <- rownames(set)[which(!(rownames(set) %in% rownames(top)[1:5000]))]

# RUVg:  estimating the factors of unwanted variation using control genes
setg <- RUVg(set, empirical, k=1)
pData(setg)

# save rle and pca plot
pdf(paste0(ol, "rle_pca_raw_RUVg_RUVs",".pdf"))
par(mfrow=c(2,3))
plotRLE(set, outline=FALSE, col=colors[x])
plotRLE(setg, outline=FALSE, col=colors[x])
plotRLE(sets, outline=FALSE, col=colors[x])
plotPCA(set, col=colors[x], cex=1,xlim=c(-1,0.8))
plotPCA(setg, col=colors[x], cex=1,xlim=c(-1,0.8))
plotPCA(sets, col=colors[x], cex=1,xlim=c(-1,0.8))
dev.off()

# choose a better method based on plots
method <- "RUVg"
set2 <- setg
# save set as Rdata
save(setg,file = paste0(ol, "setg.rda"))

# write to normalized count to txt
#write.csv(normCounts(sets), file = paste0(ol_ruv, sample, "/normCounts_RUVs.csv"), row.names = TRUE)

# DEseq2
## ----deseq2, eval=FALSE-----------------------------------
dds <- DESeqDataSetFromMatrix(countData = counts(set2),
                              colData = pData(set2),
                              design = ~ W_1 + x)

dds$x = factor(dds$x, levels = unique(dds$x))
dds <- DESeq(dds)
res <- results(dds)
summary(res)
res05 <- results(dds, alpha = 0.05)
summary(res05)

# LRT test
#dds1 <- DESeq(dds, test="LRT", reduced=as.formula("~ W_1"))
#res1 <- results(dds1)
#summary(res1)
# MA plot
pdf(paste0(ol, "MAplot.pdf"))
DESeq2::plotMA(res)
dev.off()
# volcano plot
library("EnhancedVolcano")
pdf(paste0(ol,"volcanoPlot.pdf"))
EnhancedVolcano(res,
                lab = rownames(res),
                x = 'log2FoldChange',
                y = 'pvalue')
dev.off()

# how many sig genes
res_order <- res[order(res$padj),]
res_sig <- res[abs(res$log2FoldChange) > 0.6 & (!is.na(res$padj) & res$padj < 0.05 | is.na(res$padj) & !is.na(res$pvalue) & res$pvalue < 0.01), ]
res_sig_order <- res_sig[order(res_sig$padj),]
## ----write DE dataframe into csv
write.csv(res_order, paste0(ol,"allDE_RUVs_deseq2.csv"),row.names=TRUE,quote=F)
write.csv(res_sig_order, paste0(ol,"sigDE_RUVs_deseq2.csv"),row.names=TRUE,quote=F)

## ----sessionInfo, results="asis"--------------------------
sessionInfo()
