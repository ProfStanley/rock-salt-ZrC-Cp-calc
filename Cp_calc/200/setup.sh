#!/bin/bash

#make sure you changed the fdf file for MD runs!!!!
for (( i=1; i<10; i++ )) 
do
    rm -fr 0$i
    mkdir 0$i
    cp ZrC64.fdf ./0$i/
    cp ZrC64.vectors ./0$i/
    cp ZrC64.xyz ./0$i/
    cp *.vps ./0$i/
    cp *.psf ./0$i/
    echo 0$i
done

for (( i=10; i<=50; i++ )) 
do
    rm -fr $i
    mkdir $i
    cp ZrC64.fdf ./$i/
    cp ZrC64.vectors ./$i/
    cp ZrC64.xyz ./$i/
    cp *.vps ./$i/
    cp *.psf ./$i/
    echo $i
done
