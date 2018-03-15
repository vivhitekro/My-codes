#!/bin/bash/
#cube_files=`ls -l *.cube | awk '{ print $9}' | cut -d'.' -f2 | grep -o '[0-9]*' > indices.out`
N=`cat indices.out | wc -l`
for i in `seq 1 $N`
do
index=`head -${i} indices.out | tail -1`
cp Orca.mo${index}a.cube temp.cube
echo $index
vmd -e cubes.tcl > out.out
wait
#mv temp.dat $i.dat
/c/Program\ Files\ \(x86\)/University\ of\ Illinois/VMD/tachyon_WIN32.exe -aasamples 12 -res 2000 2000 "temp.dat" -format BMP -o $index.bmp
#mv temp.bmp $i.png
done
