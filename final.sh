#!/bin/bash
source library.sh
logger "Script started"
trap quit SIGTERM
trap int SIGINT
trap cleanup EXIT
setup
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
	   echo "Invalid option: -""$opt"
	   ;;
	esac
done
if [[ "$DEBUG" -eq 1 ]]; then
	set -x
fi
SOURCE=$1
sanityCheck "$SOURCE" #exits if fails
IFS=': '
for f in $SOURCE; do
	if [[ "$DEBUG" -eq 1 ]]; then
		read hitAnyKey
	fi
	EXTENSION=${1##*.}
	EXTENSION=$(echo ${EXTENSION,,} )
	HASH=$(tail -c1000 "$f" | md5sum)
	grep -q "$HASH" "$HASHES"
        if [[ $? -eq 0 ]]; then
		if [[ "$EXTENSION" == ".jpg" ]]; then
			((JPGTOTAL++))
		else
			((VIDTOTAL++))
		fi
		PWD=$(pwd)
		if [[ "$PWD" == "$LASTPWD" ]]; then
			logDirectory "$PWD"
		fi
		setALL "$f"
		logFile "$f"
		LASTPWD="$PWD"
		copyFile "$f"
		"$HASH" >> "$HASHES" 
	else
		"Duplicate file ""$PWD""$f"" ignored." >> "$ERRLOG"
		if [[ "$EXTENSION" == ".jpg" ]]; then
			((DUPJPG++))
		else
			((DUPVID++))
		fi
	fi	
done
copyTemp
if [[ "$FORCE" -eq 1 ]]; then
	eraseSource
fi
echo "********************************************************************************"
echo "Organization complete!"
echo "$CURRENTJPG"" jpegs copied."
echo "$DUPJPG"" duplicate jpegs skipped."
echo "$CURRENTVID"" videos copied."
echo "$DUPVID"" duplicate videos skipped."
echo "********************************************************************************"

