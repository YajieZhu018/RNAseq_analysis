
# Import
import os
import sys

# Condition List
counter = 1
fl = "/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Scripts/01_STAR/input/"
il = "/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Analysis/01_Align/EJC/"
ol = "/usr/users/yzhu1/www/0vF36w1M7UjV/RS/Analysis/01_Align/EJC/"

# get condList
condList = []
with open("condition.txt") as inFile:  # where you wrote the names of each conditions
    for line in inFile:
        condList.append(line.strip())

command = "mkdir -p " + ol
os.system(command)

# Condition Loop
for cond in condList:
    outBam = ol + cond + "_merged.bam"
    inBam = il + cond + "_Rep*/Aligned.sortedByCoord.out.bam"
    # Write
    inFileName = fl + str(counter) + "_mb.txt"
    with open(inFileName,"w") as inFile:
        inFile.write("\n".join([outBam, inBam]))
    counter += 1
