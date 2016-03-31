#!/bin/bash
### get all thermal data from orca.out file when using Orca quantum chemical soft ware
##this is a bash script file 
### usage sh filename.sh

touch "final-results.txt"   ##this is where your output will be stored
s=`sed -n '/Expectation value of /=' Orca.out | tail -1`     ####get line number of final <S^2> value
scf=`sed -n '/FINAL SINGLE POINT /=' Orca.out | tail -1`     ####get line number for final SCF energy
#echo $s
#echo $scf
echo "<S^2>,SCF,Thermal Energy,Enthalpy,Free Energy,location" >> final-results.txt
echo "`head -$s Orca.out | tail -1 | cut -c 38-46`,`head -$scf Orca.out | tail -1 | cut -c 31-48`,`grep 'Total thermal energy' Orca.out | cut -c 39-53`, `grep 'Total Enthalpy' Orca.out | cut -c 40-54`,`grep 'Final Gibbs free enthalpy' Orca.out | cut -c 40-54`,,`pwd`" >> final-results.txt
### writes <S^2>, SCF, Thermal energy, Enthalpy, Free energy and location of directory (if you did not do a hessian and just want <S^2> and SCF, you can still use this script)
