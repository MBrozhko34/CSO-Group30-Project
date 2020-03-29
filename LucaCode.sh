#!/bin/bash

if [ $# -eq 0 ]; then
	echo "You have not entered anything"
elif [ $# -lt 2 ]; then
	echo "Enter the second argument"
elif [ $# -gt 2 ]; then
	echo "You cannot enter more than 2 arguments"
else
        echo "All good"  
fi

if [ $(($1 % 2)) -eq 0 ] || [ $(($2 % 2)) -eq 0 ]; then
	echo "even numbers: " $(($1 % 2)) , $(($2 % 2))
else
    	echo "no even number"
fi


#for -p in ~/*; do
#	if [ $a %7 ]; then
#        echo "$a: orange"
#else
#        break;
#fi
#done
