#!/bin/bash/
alpha=1
file_length=$1     ###this is number of lines in the header + number of atoms. I have 9600 atoms and there are 9 lines on the top in the temp.dump file, $1 is 9609
beta=$(( file_length ))
num_iter=`cat tmp.dump | wc -l`
num_iter=$(( num_iter/beta ))
for k in `seq 1 $num_iter`
do
sed -n ${alpha},${beta}p tmp.dump >> $k.ltrj
alpha=$(( file_length + 1 ))
beta=$(( beta + file_length ))
done
