#!/bin/sh

STRING=$1
STRING=$(echo "$STRING" | sed 's/.*\///')
STRING=$(echo "$STRING" | sed 's/'"$2"'//')
echo "$STRING"
