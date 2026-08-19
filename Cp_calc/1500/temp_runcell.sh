#!/bin/bash

./mkrunfile.sh
#this file runs the run.sh scripts that were created by mkrunfile.sh

for (( i=21; i<=30; i++ )) 
do
    cp run.sh ./$i/
    cd ./$i/
    sbatch run.sh
    cd ..
    echo $i
done

while qcheck|grep "myjob"  > /dev/null;
do
    echo "working..."
    sleep 3m
done

for (( i=31; i<=40; i++ )) 
do
    cp run.sh ./$i/
    cd ./$i/
    sbatch run.sh
    cd ..
    echo $i
done

while qcheck|grep "myjob"  > /dev/null;
do
    echo "working..."
    sleep 3m
done

for (( i=41; i<=50; i++ )) 
do
    cp run.sh ./$i/
    cd ./$i/
    sbatch run.sh
    cd ..
    echo $i
done
