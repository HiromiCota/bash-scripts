#!/bin/bash

THIS=`basename "$0"`
help() {
echo "This is the $THIS script, which takes the following options: \n"
echo "-d Debugging mode \n"
echo "-v Verbose \n"
echo "-h Help (this message)"
echo "-n <name> Prints information about the file."
echo "-l <dir> List the contents of the directory."
}

while [ "$1" != "" ]; do
	case $1 in
		-d )	set -x			
			;;
		-v )	VERBOSE=true
			;;
		-h )	help
			;;
		-n )	shift
			file "$1"
			;;
		-l )	shift
			echo "List contents of [$1]? (Y/N)"
			read why_en
			why_en=${why_en^^}
			if [ $why_en == "Y" ]; then
				ls "$1"
			fi	#No need for else
			;;
		*  )	help
			exit
			;;
	esac
	shift
done
