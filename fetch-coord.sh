#!/bin/bash
##bash code to get contents of files stored in different locations on you systems
##3useful for compiling all coordinates data in computational chemistry supplementary information for research papers
## first arrange a file 'coord-list.txt' in the following format
## name-of-species(do not use space character in name) /path/to/file
p=`pwd`   ##current working directory
for i in `seq 1 16`;    ##the number 16 is to be set manually, if the length of coord-list.txt is 10, set `seq 1 10`  
do
a=`head -n $i coord-list.txt | tail -1 | cut -d' ' -f1`   ##grab the name of species
#echo $a
b=`head -n $i coord-list.txt | tail -1 | cut -d' ' -f2`    ##grab the path
cd $b    ##go to original location
sv mxyz    ##this is a  command specific to my case to create xyz format coordinate file
if [ -f def2-TZVP*.xyz ]   ##if a  file def2-TZVP*.xyz  (* is the wildcard here) ecists
then
echo $a >> $p/coords   ### writes the species name to a coords file, coords is the final outpur file
cut -c1-43 def2-TZVP*.xyz >> $p/coords    ###write the atom number x y z coordinates (do a trial and error here, check if the number 43 works for you)
echo "" >> $p/coords  ##enter a new line
fi
if [ -f HESS*.xyz ]    ###if you have file names starting with a different name, in my case some files start with a name HESS*.xyz
then
echo $a >> $p/coords
cut -c1-43 HESS*.xyz >> $p/coords
echo "">> $p/coords
fi
cd $p    ##come back to working directory and loop continues
done
