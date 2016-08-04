#!/bin/bash/
inputfile="in.vivek"    ##this will be your lammps inputfile
material_studio_filename="Pd_111_5.5nm.car"   ###this is the material studio coordinate file
Atom_type_1="Pd"   ###set the atom types here, if you have more atoms add more variables
Atom_type_2="Ag"
length=`cat $material_studio_filename | wc -l`
length=$(( length - 2))   ##there are two "end" statement in .car file
###write velocities with atom_index simultaneously
echo >> temp.txt   ##3insert blank line
echo "Velocities" >> temp.txt
echo >> temp.txt

for k in `seq 5 $length` ###first 4 lines in 4 car files excluded
do
atom_index=$(( k - 4 ))
Atom=`cat $material_studio_filename | head -$k | tail -1 | tr -s ' ' | cut -d ' ' -f8`
if [ $Atom = $Atom_type_1 ]; then    ###you may need more statements if you have more atom_types
Type=1
Charge=0
else
Type=2
Charge=0
fi
x_coord=`cat $material_studio_filename | head -$k | tail -1 | tr -s ' ' | cut -d ' ' -f2`
y_coord=`cat $material_studio_filename | head -$k | tail -1 | tr -s ' ' | cut -d ' ' -f3`
z_coord=`cat $material_studio_filename | head -$k | tail -1 | tr -s ' ' | cut -d ' ' -f4`
v_x=0
v_y=0
v_z=0
echo $atom_index $Type $Charge $x_coord $y_coord $z_coord 0 0 0 >> $inputfile
echo $atom_index $v_x $v_y $v_z >> temp.txt
done
###merge all velocities in the end
cat temp.txt >> $inputfile
wait
rm -f temp.txt
