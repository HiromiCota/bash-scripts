#!/bin/bash
OLDIFS=$IFS
IFS=$'\n'
FOUND=foundfiles.txt
LOST=lostfiles.txt

echo "I am going to overwrite $FOUND and $LOST. Is this OK? (Y/N)"
read VAR
VAR=$(echo ${VAR^^})
if ! [ $VAR = "Y" ]; then
	echo "OK. Exiting..."
	exit;
fi
#Blanking $FOUND and $LOST
> "$FOUND"
> "$LOST"

while read VAR ; do
	ls | grep "$VAR"
	EXITCODE=$?
	if [ "$EXITCODE" -eq 0 ]; then
		echo "$VAR" >> "$FOUND" 
	else
		echo "$VAR" >> "$LOST"
	fi
done <medialist.txt

IFS=$OLDIFS
