
# Import
import os
import sys

# Condition List
counter = 1
fl = "/usr/users/yzhu1/www/0vF36w1M7UjV/Adi/Scripts/03_IsoformSwitch/input/"
#tl = "/scratch/yzhu1/Align/"
il = "/usr/users/yzhu1/www/0vF36w1M7UjV/Adi/Data/Fastq/Organoids/"
ol = "/usr/users/yzhu1/www/0vF36w1M7UjV/Adi/Analysis/03_IsoformSwitch/01_salmon/"
# get condList
fastqList = ["pKFO-004sCP1-KFO-TM23-O-Pan2T_Boesherz_S2_L001",
             "pKFO002sTM16-0-Pan3T_Boesherz_S1_L001",
             "pKFO002sTM37-0-Pan35T_Boesherz_S4_L001",
             "pKFO002sTM50-0-Pan54T_Boesherz_S9_L001",
             "pKFO002sTM47-0-Pan51P27F_Boesherz_S14_L002",
             "pKFO-004sCP1-KFO-TM47-O-Pan51TP27FContr_Boesherz_S14_L002",
             "pKFO002sTM56-0-Pan61T_Boesherz_S11_L002",
             "pKFO-004sCP1-KFO-TM68-O-Pan74T_Boesherz_S10_L001",
             "pKFO-004sCP1-KFO-TM77-O-Pan84T_Boesherz_S11_L001"]
condList = ["low_Rep1","low_Rep2","low_Rep3","low_Rep4",
            "high_Rep1","high_Rep2","high_Rep3","high_Rep4","high_Rep5"]
# Condition Loop
for i in range(len(condList)):
    out = ol + condList[i]
    fastq = fastqList[i]
    r1 = il + fastq + "_R1_001.fastq.gz"
    # Write
    inFileName = fl + str(counter) + "_qt.txt"
    with open(inFileName,"w") as inFile:
        inFile.write("\n".join([r1,out]))
    counter += 1
