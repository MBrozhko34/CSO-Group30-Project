#!/bin/bash

#Checks if the correct number of arguments have been entered by the user.

if [ $# -ne 3 ]; then
	echo "Error: invalid number of arguments"
	echo "Command usage: cpc -cz source-file target-directory"
	exit
fi

#Checks if the source file provided exists

if [ ! -e $2 ]; then
	echo "Error: source file '$2' does not exist"
	exit
fi

#Checks if target directory provided exists. Asks for user confirmation to create the directory if it does not exist.

if [ ! -d $3 ]; then
	echo -n "Target directory does not exist. Create this directory (Y/N)?"
	read create
	
	#Checks if user wants to create the directory or not
	if [ $create == "Y" ]; then
		mkdir "$3"
		echo "Target directory created"
	elif [ $create == "N" ]; then
		echo "Error: permission to create target directory denied. Directory '$3' does not exist"
		exit
	fi
fi

#Checks if a valid cpc option has been provided by the user

if [ $1 == "-c" ]; then
	echo "-c works"
elif [ $1 == "-z" ]; then
	echo "-z works"
else
	echo "Error: invalid cpc option entered. Must be -c or -z"
	exit
fi
