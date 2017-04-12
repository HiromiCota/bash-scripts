#!/bin/bash

echo "Please enter an integer:"
read INPUT 
echo "You entered $INPUT"
if ! [[ $INPUT =~ [[:digit:]] ]]; then
	echo "$INPUT is probably not a number! :("
elif [[ $INPUT =~ [.] ]];then
	echo "$INPUT is a floating point number. :("
elif [[ $INPUT -eq 0 ]]	;then
	echo "$INPUT is zero and therefore possibly even, but I'm not a mathematician!"
else
	REMAINDER=$(echo "scale=0; $INPUT%2" | bc )
	if [[ "$REMAINDER" -eq 0 ]] ; then
		echo "$INPUT is even."
	else 
		echo "$INPUT is odd."
	fi
fi
