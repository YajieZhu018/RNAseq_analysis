# to save the input and output file names in *_map.txt
# Import
import os
import sys

# Condition List
counter = 1
fl = "/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Scripts/01_STAR/input/"  # where to save *_map.txt
il = "/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Data/Fastq/"  # folder of fastq files
ol = "/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/01_Align/"  # folder of output bam files

# get condList
fastqList = ['p1522scontrol1_Papantonis_S93','p1522scontrol2_Papantonis_S95', 'p1522sCtcf1_Papantonis_S94','p1522sCtcf2_Papantonis_S96']  # names of fastq
condList = ["CTCFcontrol_Rep1","CTCFcontrol_Rep2","siCTCF_Rep1","siCTCF_Rep2"]  # names of bam 

# Condition Loop
for i in range(len(condList)):
    fastq = fastqList[i]
    cond = condList[i]
    read = il + fastq + "_R1_001.fastq.gz " + il + fastq + "_R2_001.fastq.gz "    # change the suffix accordingly
    sample = ol + cond + "/"
    command = "mkdir -p " + sample  # create subfolder for each sample
    os.system(command)
    # Write
    inFileName = fl + str(counter) + "_map.txt"
    with open(inFileName,"w") as inFile:
        inFile.write("\n".join([read,sample]))
    counter += 1
