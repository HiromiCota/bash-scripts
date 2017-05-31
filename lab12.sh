#!/bin/bash

LINE=""
VAR=""
OLDIFS=$IFS
IFS=$'\n'
quit(){
exit
}
cleanup(){
IFS=$OLDIFS
}
grab(){
VAR=${LINE%%,*}
}
bump(){
LINE=${LINE#*,}
}
trap quit SIGINT SIGTERM
trap cleanup EXIT

COUNTER=0
declare -a FNAME
declare -a LNAME
declare -a COMP
declare -a STREET
declare -a CITY
declare -a COUNTY
declare -a STATE
declare -a ZIP
declare -a PHONE
declare -a FAX
declare -a EMAIL
declare -a WEB

while IFS= read -r LINE
do
	LINE=$(echo "$LINE" | sed 's/"//g')
	grab; FNAME["$COUNTER"]="$VAR"; bump
	grab; LNAME[$COUNTER]=$VAR; bump
	grab; COMP[$COUNTER]=$VAR; bump
	grab; STREET[$COUNTER]=$VAR; bump
	grab; CITY[$COUNTER]=$VAR; bump
	grab; COUNTY[$COUNTER]=$VAR; bump
	grab; STATE[$COUNTER]=$VAR; bump
	grab; ZIP[$COUNTER]=$VAR; bump
	grab; PHONE[$COUNTER]=$VAR; bump
	grab; FAX[$COUNTER]=$VAR; bump
	grab; EMAIL[$COUNTER]=$VAR; bump
	grab; WEB[$COUNTER]=$VAR; bump
	((COUNTER++))
done < "$1"	
max=${#FNAME[@]}
for (( i=0; i<max; i++ )) ; do
	echo -n "\""${FNAME[$i]}"\",\""${LNAME[$i]}"\",\""${COMP[$i]}"\","
	echo -n "\""${STREET[$i]}"\",\""${CITY[$i]}"\",\""${COUNTY[$i]}"\","
	echo -n "\""${STATE[$i]}"\",\""${ZIP[$i]}"\",\""${PHONE[$i]}"\","
	echo -n "\""${FAX[$i]}"\",\""${EMAIL[$i]}"\",\""${WEB[$i]}"\""
	echo
done
	
