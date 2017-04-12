#!/bin/bash

echo "Please enter a number:"
read INPUT 
echo "You entered $INPUT"
if ! [[ $INPUT =~ [[:digit:]] ]]; then
	echo "$INPUT is probably not a number! :("
else	
	FPINPUT=$(echo "scale=9; $INPUT > 5" | bc )
	if [[ "$FPINPUT" -eq 1 ]] ; then
		echo "$INPUT is greater than 5!"
	elif [[ "$INPUT" -eq 5 ]];then
		echo "$INPUT is equal to 5!"
	elif [[ "$FPINPUT" -eq 0 ]]; then
		echo "$INPUT is less than 5!"	
	fi
fi
