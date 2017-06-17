#!/bin/bash
source library.sh
logger "Script started"
trap quit SIGTERM
trap int SIGINT
trap cleanup EXIT
setup()
while getopts ":f:d" opt; do
	case ${opt} in
	 f)
	   FORCE=1
	   echo "File move ON."
	   shift
	   ;;
	 d)
	   DEBUG=1
	   echo "Debug mode ON."
	   shift
	   ;;
	 \?)
	   echo "Invalid option: -"$opt""
	   ;;
	esac
done
SOURCE=$1
sanityCheck $SOURCE #exits if fails
IFS=': '
for f in "$SOURCE"; do
	HASH=$(tail -c1000 "$f" | md5sum)
	grep -q "$HASH" "$HASHES"
	if [[ $? -eq 1 ]]; then #only process files not in HASHES
		PWD=$(pwd)
		if [[ $PWD == $LASTPWD]]; then
			logDirectory "$PWD"
		setALL "$f"
		logFile "$f"
		LASTPWD="$PWD"
		copyFile "$f"
		"$HASH" >> "$HASHES" 
	else
		ERRLOG <<  "Duplicate file ""$PWD""$f"" ignored."
	fi	
done

echo $DIR

