#!/bin/bash

for (( i=1; i<10; i++ )) 
do
#    mkdir 0$i
#make sure you changed the fdf file for MD runs!!!!
    cp sic.fdf ./0$i/
    echo $i
    cp ./0$i/sic.XV ./0$i/XV0
    rm -f ./0$i/sic.vectors
    rm -f ./0$i/sic.xyz
    rm -f ./0$i/Si250H40.output
    rm -f ./0$i/a.out
    rm -f ./0$i/a.run
    rm -f ./0$i/pehostfile
done

for (( i=10; i<=50; i++ )) 
do
#    mkdir $i
#make sure you changed the fdf file for MD runs!!!!!
    cp sic.fdf ./$i/
    echo $i
    cp ./$i/sic.XV ./$i/XV0
    rm -f ./$i/sic.vectors
    rm -f ./$i/sic.xyz
    rm -f ./$i/Si250H40.output
    rm -f ./$i/a.out
    rm -f ./$i/a.run
    rm -f ./$i/pehostfile
done
