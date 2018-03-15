# this is the driver bash script
#!/bin/bash
for i in `seq 1 51`
do
start_orbital=`head -1 filename${i}.txt | awk '{print $1}'`
#dz2=`grep "24 Ru dz2" filename${i}.txt`
#dxy=`grep "24 Ru dxy" filename${i}.txt`
#dx2y2=`grep "24 Ru dx2y2" filename${i}.txt`
#dyz=`grep "24 Ru dyz" filename${i}.txt`
#dxz=`grep "24 Ru dxz" filename${i}.txt`
python3 test.py filename${i}.txt >> Ru_percent.txt
done
