#!/bin/bash

TEMP=/root/filelist.txt
why_en="N"
COUNTER=0
if [ -e "$TEMP" ]; then
	echo "$TEMP already exists. This script will overwrite the file."
	echo "Is this OK? (Y/N)"
	read why_en
	why_en=${why_en^^}
	if [ "$why_en" != "Y" ]; then
		echo "Exiting without changing "$TEMP"."
		exit #Does this trigger cleanup?
	fi
fi
cleanup(){
	rm $TEMP
}

ls -LRa / > $TEMP

while IFS= read -r VAR
do
	counter=${counter+1}
	if [ "$VAR" ]; then #This should test to see if it's a file
		echo "$VAR" | sed #Replace lead with File : 
	elif [ "$VAR" ]; then #This should test to see if it's a dir
		echo "$VAR" | sed #Replace lead with Directory :
	#Ignore everything else.
	fi
done < "TEMP"

trap cleanup EXIT
