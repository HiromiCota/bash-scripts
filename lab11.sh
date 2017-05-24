#!/bin/bash
source functionLibrary.sh

trap quit SIGINT SIGTERM
trap cleanup EXIT

SOURCE=./*.txt
TXT=/*.txt
BASE=~
getOpts "$1" 
OPTIONS=$?  
echo $OPTIONS 
TEMP=$(mktemp -d)
if [ "$OPTIONS" -ne -1 ]; then
	if [ "$OPTIONS" -ge 2 ]; then
		if [ -d "$2" ]; then #Don't let users give garbage paths
			SOURCE=${2}/*.txt
		fi
		if [ -d "$3" ]; then
			BASE=${3}
		fi
	fi
	if [[ $((OPTIONS % 2 )) -eq 1 ]]; then
		FORCE=1
	else
		FORCE=0
	fi
else
	exit
fi
for f in $SOURCE; do
	TARGET=$TEMP
	YEAR=$(getYY $f)
	MONTH=$(getMM $f)
	DAY=$(getDD $f)
	TARGET="$TARGET/$YEAR" 
	if [ ! -d $TARGET ]; then
		mkdir "$TARGET"
	fi
	TARGET="$TARGET/$MONTH"
	if [ ! -d $TARGET ]; then
		mkdir "$TARGET"
	fi
	TARGET="$TARGET/$DAY"
	if [ ! -d $TARGET ]; then
		mkdir "$TARGET"
	fi
	cp $f $TARGET
done
if [ "$FORCE" -eq 1 ]; then
	mv -f "$TEMP"/* "$BASE"
	rm -rf "$SOURCE"
else
	cp -Rf "$TEMP"/* "$BASE"
fi

