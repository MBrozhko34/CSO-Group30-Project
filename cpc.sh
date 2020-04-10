#!/bin/bash

#script purpose: copies, compresses or decompresses a source file, then stores it in a specified target directory

#declaring variables using the inputs from the command line
cpc_option=$1
source_file=$2
target_dir=$3

#displays guidelines on how to use the cpc command
display_command_usage() {
	echo "Command usage: cpc [-c or -z] source-file target-directory"
}

#checks if user wants to create a target directory if the name entered does not match an existing directory
create_directory() {
	if [ $1 == "Y" ]; then
		mkdir "$2"
		echo "Target directory '$2' created"
	elif [$1 == "N"]; then
		echo "Error: permission to create target directory denied"
		echo "Directory '$2' does not exist"
		exit
	fi
}

#copies source file to the desired target directory
copy_file() {
	cp $1 $2
	echo "File '$1' copied to directory '$2'"
}

#compresses source file and moves it to the desired target directory
compress_file() {
	gzip $1
	mv $1.gz $2
	echo "File '$1' compressed and moved to directory '$2'"
}

#decompresses source file and removes the original compressed version
decompress_file() {
	gunzip -d $1 > $2/$(basename "$1" .gz)
	rm $(basename "$1" .gz)
	echo "File "$1" decompressed and moved to directory '$2'"
}

#checks if the correct number of arguments have been entered by the user
if [ $# -ne 3 ]; then
	echo "Error: invalid number of arguments"
	display_command_usage
	exit
fi

#checks if a valid cpc option has been entered by the user
if [ $cpc_option != "-c" ] && [ $cpc_option != "-z" ]; then
	echo "Error: cpc option is invalid"
	display_command_usage
	exit
fi

#checks if the source file provided exists
if [ ! -e $source_file ]; then
	echo "Error: source file '$source_file' does not exist"
	exit

fi

#checks if target directory provided exists
#asks for user confirmation to create the directory if it does not exist
if [ ! -d $target_dir ]; then
	echo -n "Target directory does not exist. Create this directory (Y/N)?"
	read create
	create_directory $create $target_dir
fi

#checks the cpc option and carries out the process associated with it
if [ $cpc_option == "-c" ]; then
	copy_file $source_file $target_dir
else
	if [ ${2##*.} != "gz" ]; then
		compress_file $source_file $target_dir
	else
		decompress_file $source_file $target_dir
	fi
fi
