#!/bin/bash

FCOUNTER=0
DCOUNTER=0
TEMP=$(mktemp /tmp/filelist.XXXXXXXXXXX)
quit(){
        exit
}
cleanup(){
        rm $TEMP
}
trap quit SIGINT SIGTERM
trap cleanup EXIT
find / -type f -printf '%f\n' > $TEMP

while IFS= read -r VAR
do
        ((FCOUNTER++))
        echo "File $FCOUNTER $VAR"
done < "$TEMP"
