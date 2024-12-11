
# Import
import os
import sys

# Condition List
counter = 5
fl = "/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Scripts/02_HTSeq/input/"
il = "/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/01_Align/"
#tl = "/scratch/yzhu1/Align/"
ol = "/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/02_Count/"

# get condList
condList = ["CTCFcontrol_Rep1","CTCFcontrol_Rep2","siCTCF_Rep1","siCTCF_Rep2"]
command = "mkdir -p " + ol
os.system(command)

# Condition Loop
for cond in condList:
    bam = il + cond + "/Aligned.sortedByCoord.out.bam"
    out = ol + cond + ".txt"

    # Write
    inFileName = fl + str(counter) + "_count.txt"
    with open(inFileName,"w") as inFile:
        inFile.write("\n".join([bam,out]))
    counter += 1
