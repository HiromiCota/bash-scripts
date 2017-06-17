#!/bin/bash
source library.sh

trap quit SIGINT SIGTERM
trap cleanup EXIT
setup()
#FORCE=0
#DEBUG=0
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
sizeCheck $SOURCE #exits if fails
utilCheck	  #exits if fails
#TEMP=$(mktemp -d)
#HASHES=$(touch "$TEMP"/hashes)
#OLDIFS=IFS
IFS=': '
for f in "$SOURCE"; do
	HASH=$(tail -c1000 "$f" | md5sum)
	grep -q "$HASH" "$HASHES"
	if [[ $? -eq 1 ]]; then #only process files not in HASHES
		set $(exiv2 -g Exif.Image.DateTime -Pv "$f")
		  if [[ $? -eq 0 ]]; then
			YEAR="$1"
			MONTH="$2"
			DAY="$3"
			HOUR="$4"
			MINUTE="$5"
			SECOND="$6"
			MAKE=$(exiv2 -g Exif.Image.Make -Pv "$f")
			MODEL=$(exiv2 -g Exif.Image.Model -Pv "$f")
 		   else
			setALL "$f"			
		   fi
	fi
	"$HASH" >> "$HASHES" #

echo $DIR

