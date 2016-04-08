#!/bin/bash
##this bash scripts pulls charge and spin populations for selected atoms from Orca.out
p=`pwd`
for j in `seq 1 13`;
do
a=`head -n $j coord-list.txt | tail -1 | cut -d',' -f1`    ##arrange species name and directory location, comma delimited
b=`head -n $j coord-list.txt | tail -1 | cut -d',' -f2`
cd $b
rm -f charge-spin.txt
pwd
sed -n "/LOEWDIN REDUCED ORBITAL CHARGES AND SPIN POPULATIONS/,/MAYER POPULATION ANALYSIS/p" Orca.out >> charge-spin.txt
for i in 0 2 3 4 6 7 9 30 32 40 50                  ### this for loop is over atom index in .xyz file - 1, so atom 1 is represented as 0 here
do
index=$((i+1))     ###this is the index as per .xyz file
if [ $i -eq 0 ]
 then
 echo "Fe",$index >> $p/CS_$a.txt
 charge=`grep -A 4 " $i " charge-spin.txt | grep ' d :' | head -1 | cut -c30-46`    ##yes I have no shame, this pulls charge on 'd'orbital for Fe. this code will be later compatmentalized for most atoms
 spin=`grep -A 4 " $i " charge-spin.txt | grep ' d :' | head -2 | tail -1 | cut -c30-46`
 echo "CHARGE ="$charge >> $p/CS_$a.txt
 echo "SPIN ="$spin >> $p/CS_$a.txt

elif [ $i -eq 30 ] || [ $i -eq 40 ]
then
 echo "N",$index >> $p/CS_$a.txt
 charge=`grep -A 4 " $i " charge-spin.txt | grep ' p :' | head -1 | cut -c30-46`
 spin=`grep -A 4 " $i " charge-spin.txt | grep ' p :' | head -2 | tail -1 | cut -c30-46`
 echo "CHARGE ="$charge >> $p/CS_$a.txt
 echo "SPIN ="$spin >> $p/CS_$a.txt

elif [ $i -eq 32 ]
then
 echo "O",$index >> $p/CS_$a.txt
 charge=`grep -A 4 " $i " charge-spin.txt | grep ' p :' | head -1 | cut -c30-46`
 spin=`grep -A 4 " $i " charge-spin.txt | grep ' p :' | head -2 | tail -1 | cut -c30-46`
 echo "CHARGE ="$charge >> $p/CS_$a.txt
 echo "SPIN ="$spin >> $p/CS_$a.txt

else
 echo "C",$index >> $p/CS_$a.txt
 charge=`grep -A 4 " $i " charge-spin.txt | grep ' p :' | head -1 | cut -c30-46`
 spin=`grep -A 4 " $i " charge-spin.txt | grep ' p :' | head -2 | tail -1 | cut -c30-46`
 echo "CHARGE ="$charge >> $p/CS_$a.txt
 echo "SPIN ="$spin >> $p/CS_$a.txt

fi
done
cd $p
done
