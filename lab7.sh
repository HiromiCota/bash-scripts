#!/bin/sh

STRING=$1
SLASH='/'
if [ "$STRING" !=  "$SLASH" ]; then
	STRING=$(echo "$STRING" | sed 's/.*\///')
	STRING=$(echo "$STRING" | sed 's/'"$2"'//')
fi
echo "$STRING"
