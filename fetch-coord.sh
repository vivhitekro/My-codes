#!/bin/bash
p=`pwd`
for i in `seq 1 16`;
do
a=`head -n $i coord-list.txt | tail -1 | cut -d' ' -f1`
#echo $a
b=`head -n $i coord-list.txt | tail -1 | cut -d' ' -f2`
cd $b
sv mxyz
if [ -f def2-TZVP*.xyz ]
then
echo $a >> $p/coords
cut -c1-43 def2-TZVP*.xyz >> $p/coords
echo "" >> $p/coords
fi
if [ -f HESS*.xyz ]
then
echo $a >> $p/coords
cut -c1-43 HESS*.xyz >> $p/coords
echo "">> $p/coords
fi
cd $p
done
