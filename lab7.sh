#!/bin/sh

STRING=$1
SLASH='/'
if [ "$STRING" !=  "$SLASH" ]; then
	STRING=${STRING##*/}
fi
echo "$STRING"
