#!/bin/bash
# Script name: evenfruit.sh
# By Michael Brozhko

#Part A:

rangeStart=0
rangeEnd=0

# This function takes a single argument which is the number of
# parameters to read and returns the read input.
readInputs()
{
	# local 'argument' to this function
	toRead=$1
	while true; do
		echo "Enter $toRead integer[s] please: "
		read -a values
		if [ ${#values[@]} -ne $toRead ]; then
 	   		echo "Illegal number of parameters, you entered "${#values[@]}", but $toRead is needed."
		else
   			echo "Your typed: "${values[@]}". Thank you!";
			if [ $toRead -eq 1 ]; then
				rangeEnd=${values[0]}
			else
				rangeStart=${values[0]}
				rangeEnd=${values[1]}
			fi
			return 0
		fi
	done
}

# Main logic
if [ "$#" -eq 0 ]; then
	echo "You have not entered the two integers that program needs"
	readInputs 2
elif [ "$#" -eq 1 ]; then
	rangeStart=$1
	echo "You have entered only one argument, we require two"
	readInputs 1
elif [ "$#" -eq 2 ]; then
	# The user has entered what has been asked, all OK
	rangeStart=$1
	rangeEnd=$2
elif [ "$#" -gt 2 ]; then
	echo "You have entered more than two arguments, the program will use the first two"
	rangeStart=$1
	rangeEnd=$2
fi

# Check if the parameters are numbers, if not exit the program
if [[ "$rangeStart" != *[[:digit:]]* ]] ; then
	echo "The value entered for the start of the range is not numeric: "$rangeStart
	echo "Exiting..."
	exit 1
fi

if [[ "$rangeEnd" != *[[:digit:]]* ]] ; then
	echo "The value entered for the end of the range is not numeric: "$rangeEnd
	echo "Exiting..."
	exit 2
fi

echo "Range: $rangeStart $rangeEnd"


#Other parts:

i=$rangeStart
while [ $i -le $rangeEnd ] 
do
	if [ $i -eq $rangeEnd ] ; then
		break
	elif [ $(($i % 2)) -eq 0 ] ; then
		echo $i
		r1=$(( $i % 7 ))
		r2=$(( $i % 11 ))
		r3=$(( $i % 13 ))
		if [ "$r1" -eq 0 ]; then
    			echo "$i:orange"
		elif [ "$r2" -eq 0 ]; then
    			echo "$i:banana"
		elif [ "$r3" -eq 0 ]; then
    			echo "$i:pear"	
		fi
	fi
	i=$(( $i + 1 ))
done
