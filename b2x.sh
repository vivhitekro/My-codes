#!/bin/bash
# Convert B_coord file to xyz format
# Usage: sh b2x.sh
# Note: you must have the B_coord file to be converted in the same directory you execute this script
# Developed by Vivek Sinha, vsinha027@gmail.com
file=${PWD##*/}
line_1=`grep -n -m 2 atoms B_coord | cut -d':' -f1 | head -1`
line_2=`grep -n -m 2 atoms B_coord | cut -d':' -f1 | tail -1`
N=$((line_2 - line_1 -1 )) # number of atoms
echo $N > $file.xyz
echo $blank_space >> $file.xyz
count=0
start_coord=`grep -n -m 2 'coordinates' B_coord | cut -d':' -f1 | head -1`
start_coord=$((start_coord+1))
end_coord=`grep -n -m 2 'coordinates' B_coord | cut -d':' -f1 | tail -1`
end_coord=$((end_coord-1))
a=`grep symbol B_coord | sed -e 's/^[[:space:]]*//' | cut -d' ' -f4 | cut -d'=' -f2 | cut -d'"' -f2 > elements`
b=`sed -n ${start_coord},${end_coord}p B_coord | sed -e 's/^[[:space:]]*//' > coords`
awk -F" "  '{$1*=0.529177;$2*=0.529177;$3*=0.529177;print}' coords > coord_angs # convert to Angstrom from a.u. by multiplying with 0.529177
wait
paste  elements coord_angs >> $file.xyz
rm -f elements coords coord_angs
echo "created $file.xyz"
