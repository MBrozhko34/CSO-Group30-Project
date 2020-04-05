#!/bin/bash

#checks if user wants to create target directory if the name entered does not match an existing directory
create_directory() {
	if [ $1 == "Y" ]; then
		mkdir "$2"
		echo "Target directory created"
	elif [$1 == "N"]; then
		echo "Error: permission to create target directory denied. Directory '$2' does not exist"
	fi
}

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
	//${2##*.}

fi

#Checks if target directory provided exists. Asks for user confirmation to create the directory if it does not exist.

if [ ! -d $3 ]; then
	echo -n "Target directory does not exist. Create this directory (Y/N)?"
	read create
	create_directory $create $3
fi

#Checks if a valid cpc option has been provided by the user

if [ $1 == "-c" ]; then
	cp $2 $3
	echo "-c works"
elif [ $1 == "-z" ]; then
	if [ ${2##*.} != "gz" ]; then
		gzip $2
		echo "-z works"
	else
		gunzip $2
		echo "-z works"
	fi
else
	echo "Error: invalid cpc option entered. Must be -c or -z"
	exit
fi
