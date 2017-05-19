#!/bin/bash
source functionLibrary.sh

trap quit SIGINT SIGTERM
trap cleanup EXIT

SOURCE=.
TARGET=~
OPTIONS=0
OPTIONS=$(getOpts "$1" )
if [ "$OPTIONS" -ne 0 ]; then
	if [ "$OPTIONS" -gt 2 ]; then
		if [ -d "$2" ]; then #Don't let users give garbage paths
			SOURCE=$2
		fi
		if [ -d "$3" ]; then
			TARGET=$3
		fi
	fi
	if [[ $((OPTIONS % 2 )) -eq 1 ]]; then
		FORCE=1
	fi
else
	exit
fi
for f in $SOURCE; do
	YEAR=$(getYY "$f")
	MONTH=$(getMM "$f")
	DAY=$(getDD "$f")
	TARGET="$TARGET/$YEAR" 
	if [ ! -d "$TARGET" ]; then
		mkdir $TARGET
	fi
	TARGET="$TARGET/$MONTH"
	if [ ! -d "$TARGET" ]; then
		mkdir $TARGET
	fi
	TARGET="$TARGET/$DAY"
	if [ ! -d $TARGET ]; then
		mkdir $TARGET
	fi
	if [ $FORCE -eq 1 ]; then
		mv $f $TARGET
	else
		cp $f $TARGET
	fi
done
	
