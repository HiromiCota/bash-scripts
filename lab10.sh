#!/bin/bash

FCOUNTER=0
DCOUNTER=0
TEMP=$(mktemp /tmp/filelist.XXXXXXXXXXX)
quit(){
	exit
}
cleanup(){
	rm $TEMP
}
trap quit SIGINT SIGTERM
trap cleanup EXIT
ls -Ra1 / > $TEMP

while IFS= read -r VAR
do
	if [[ $VAR == "./"* || $VAR == "/"* ]]; then #Directory test
		((DCOUNTER++))
		echo "Directory $DCOUNTER $VAR"
	elif [[ $VAR == "." || $VAR == ".." || $VAR == "" || $VAR == ":" ]] ; then
		: #Ignore header, blank lines, and pseudodirectories (. ..)
	else #Looks like a file
		((FCOUNTER++))
		echo "File "$FCOUNTER" "$VAR
	fi
done < "$TEMP"

