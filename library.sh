quit() {
exit
}
cleanup() {
:
}
setup() {
export FORCE=0
export DEBUG=0
export SOURCE
export TEMP=$(mktemp -d)
export TARGET="$TEMP"
export OLDIFS=IFS
export YEAR
export MONTH
export DAY
export HOUR
export SECOND
export MAKE
export MODEL
export HASH
export HASHES=$(touch "$TEMP"/hashes)
export LOG=$(touch "$TEMP"/log)
export FAIL=0
export TIME
export DATE
export PWD
}
sizeCheck() {
local FREE=`df -k --output=avail "$1" | tail -n1`
local USED=`du -sb "$1" | cut -f1`
local NEEDED=$((USED*2))
if [[ "$FREE" -lt "$NEEDED" ]]; then
	echo "Not enough space available!"
	echo ""$FREE"KB free."
	echo ""$NEEDED"KB needed."
	exit
else
	return 0
fi
}

utilCheck() {
exiv2 | grep "command not found"
if [[ $? -eq 0 ]]; then
	FAIL=1
	echo "This script requirse exiv2 binary."
fi
md5sum final.sh | grep "command not found"
if [[ $? -eq 0 ]]; then
	FAIL=1
	echo "This script requires md5sum binary."
fi
if [[ FAIL -eq 1 ]];then
	exit
fi
}
sanityCheck() {
sizeCheck $1
utilCheck
}
setDATE() {
DATE=$(stat $1 | grep Modify | cut -d' ' -f2)
}
setYEAR() {
YEAR=$(echo $DATE | cut -d'-' -f1)
}
setMONTH() {
MONTH=$(echo $DATE | cut -d'-' -f2)
}
setDAY() {
MONTH=$(echo $DATE | cut -d'-' -f3)
}
setTIME() {
TIME=$(stat $1 | grep Modify "$VAR" | cut -d' ' -f3)
}
setHOUR() {
HOUR=$(echo "$TIME" | cut -c1-2)
}
setMINUTE() {
MINUTE=$(echo "$TIME" | cut -c4-5)
}
setSECOND() {
SECOND=$(echo "$TIME" | cut -c7-8)
}
setALL() {
set $(exiv2 -g Exif.Image.DateTime -Pv "$1")
	if [[ $? -eq 0 ]]; then
		YEAR="$1"
		MONTH="$2"
		DAY="$3"
		HOUR="$4"
		MINUTE="$5"
		SECOND="$6"
		MAKE=$(exiv2 -g Exif.Image.Make -Pv "$f")
		MODEL=$(exiv2 -g Exif.Image.Model -Pv "$f")
 	else
		setDATE $1
		setTIME $1
		setYEAR
		setMONTH
		setDAY
		setHOUR
		setMINUTE
		setSECOND
		MAKE="Unknown_Manufacturer"
		MODEL="Unknown_Camera"
	fi
}
logDirectory() {
echo -e "\tDirectory : "$1"" >> "$LOG"
}
logFile() {
echo "File : "$1" "$DATE" "$TIME" "$MAKE" "$MODEL"" >> "$LOG"
