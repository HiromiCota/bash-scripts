#!/bin/bash
OLDIFS=$IFS
IFS=$'\n'
LIST=fileList.txt
UGLYXML=temp.txt
DIFF=diff.txt
CLEANXML=clean.txt
INPUT=media.xml
ls *.m?? | sort > "$LIST"
 
> "$DIFF"
> "$UGLYXML"
> "$CLEANXML"

cat "$INPUT" | grep filename | grep "\.m" | sort | uniq >> "$UGLYXML"
while read VAR; do
	VAR=${VAR#*>}
	VAR=${VAR%<*}
	echo "$VAR" >> "$CLEANXML"
done <"$UGLYXML"

diff "$LIST" "$CLEANXML" > "$DIFF"

echo "Files not in $INPUT"
cat "$DIFF" | grep \< | sed 's/<//'
echo "Files not in directory."
cat "$DIFF" | grep \> |sed 's/>//'
cat "$DIFF" | grep \< | wc -l | xargs echo -n
echo " media files in medialab directory that are NOT listed in $INPUT"
cat "$DIFF" | grep \> | wc -l | xargs echo -n
echo " media files in $INPUT that are NOT in medialab directory."

IFS=$OLDIFS
