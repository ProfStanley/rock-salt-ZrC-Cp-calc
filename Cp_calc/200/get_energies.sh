#!/bin/bash

rm -f energies
touch energies

for (( i=1; i<10; i++ )) 
do
    cd ./0$i/
    grep 'E_KS(eV) =' ZrC64.out >> ../energies
    cd ..
    echo 0$i
done

for (( i=10; i<=50; i++ )) 
do
    cd ./$i/
    grep 'E_KS(eV) =' ZrC64.out >> ../energies
    cd ..
    echo $i
done
