import os
import sys
import numpy as np
import re
from numpy import loadtxt
import fileinput
infile=sys.argv[1]
#infile='filename40.txt' #supplied from driver program
outfile='orbital40.txt' #supplied from driver program
#start_orb=sys.argv[2]  #supplied from driver program
file = open(infile,'r')
start_orb=int(file.readline().strip().split(' ')[0])   # readline reads the first line, strip removes the newline at end, split splits it at whitespace, and [0] returns the first element
dxy = ("24 Ru dx2y2")
dxz = ("24 Ru dxz")
dz2 = ("24 Ru dz2")
count = 0
lines=[]
cont=[]
newfile=open(outfile,'w')
for line in file:
        if all(s in line for s in dxy) or all(s in line for s in dxz) or all(s in line for s in dz2):

                count += 1
                if line.startswith("24 Ru dx2y2"):

                        line1=line.strip()[12:]
                        line2 = re.sub( '\s+', ' ', line1 ).strip()
                        newfile.write(line2)
                        newfile.write('\n')
                if line.startswith("24 Ru dxy") or line.startswith("24 Ru dyz") or line.startswith("24 Ru dxz") or line.startswith("24 Ru dz2"):
                        line1=line.strip()[10:]
                        line2 = re.sub( '\s+', ' ', line1 ).strip()
                        newfile.write(line2)
                        newfile.write('\n')
file.close()
newfile.close()
if os.stat(outfile).st_size != 0:
        array=np.loadtxt('orbital40.txt',delimiter=' ')
        num_orbs=array.shape[1]
        for i in range(0,num_orbs):
                if array.sum(axis=0)[i] > 8:
                        print(start_orb,array.sum(axis=0)[i])
                        start_orb += 1
