# run this script to generate an input count table for RUVseq
# Import
import os
import sys
import pandas as pd


ol = "/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/02_Count/"

condList = ["CTCFcontrol_Rep1","CTCFcontrol_Rep2","siCTCF_Rep1","siCTCF_Rep2"]
# gene number in counts: wc -l *txt
n = 54633

# get gene ID as index
inFileName = ol + condList[0] + ".txt"
inFile = pd.read_csv(inFileName,sep = "\t", header = None)
index = list(inFile.loc[:n,0])

# initialize count_table, index = geneID, column = cond
count_table = pd.DataFrame(index = index, columns = condList)

# for inFile in inFileList:
for cond in condList:
    # load as df
    inFileName = ol + cond + ".txt"
    inFile = pd.read_csv(inFileName,sep = "\t", header = None)
    # get [2][0,50564] and add into count_table
    count_table[cond] = list(inFile.loc[:n,2])

# save to tab-separated txt
outFileName = ol + "table_count_siCTCF.txt"
count_table.to_csv(outFileName, header=True, index=True, sep='\t')

# save count table as excel, sheetxxx
#outFileName = ol + "count_table.xlsx"
#with pd.ExcelWriter(outFileName, engine='openpyxl',mode='a') as outFile:
     #count_table.to_excel(outFile,sheet_name = "Pulldown")
