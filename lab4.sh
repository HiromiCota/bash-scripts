#!/bin/bash

echo "Please enter an integer:"
read INPUT
UPPER=100
LOWER=50

if [[ $INPUT =~ [[:digit:]] && "$INPUT" -ge $LOWER && "$INPUT" -le $UPPER ]]; then
	echo "$INPUT is an integer between $LOWER and $UPPER."
else
	echo "$INPUT is not an integer $LOWER and $UPPER."
fi

