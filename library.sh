quit() {
exit
}
int() {
logger "Program terminated by user"
quit
}
cleanup() {
if [ -d "$TEMP" ]; then
	rm -rf "$TEMP"
fi
}
setup() {
export HOMEDIR=$( getent passwd "$USER" | cut -d':' -f6 )
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
export HASHES=$( touch "$TEMP"/hashes )
export LOG=$( touch "$HOMEDIR"/final_event.log)
export ERRLOG=$( touch "$HOMEDIR"/final_error.log )
export FAIL=0
export TIME
export DATE
export PWD
export EXTENSION
export NAME
export JPGTOTAL=0
export CURRENTJPG=1
export VIDTOTAL=0
export CURRENTVID=1
export DUPVID=0
export DUPJPG=0
export PWD=$(pwd)
export LASTPWD=$PWD
}
sizeCheck() {
local FREE=$( df -k --output=avail "$1" | tail -n1 )
local USED=$( du -BK "$1" | cut -d'K' -f1 )
local NEEDED="$USED" 
if [[ "$FREE" -lt "$NEEDED" ]]; then
	echo "Not enough space available!"
	echo "$FREE""KB free."
	echo "$NEEDED""KB needed."
	"Insufficient space for temporary files. Halting." >> "$ERRLOG"
	exit
else
	return 0
fi
}

utilCheck() {
exiv2 -q | grep "command not found"
if [[ $? -eq 0 ]]; then
	FAIL=1
	echo "This script requirse exiv2 binary."
	"Missing dependency: exiv2" >> "$ERRLOG"
fi
md5sum final.sh | grep "command not found"
if [[ $? -eq 0 ]]; then
	FAIL=1
	echo "This script requires md5sum binary."
	"Missing dependency: md5sum" >> "$ERRLOG"
fi
if [[ FAIL -eq 1 ]];then
	"Exiting unsuccessfully." >> "$ERRLOG"
	exit
fi
}
sanityCheck() {
sizeCheck "$1"
utilCheck
}
setDATE() {
DATE=$( stat "$1" | grep Modify | cut -d' ' -f2 )
}
setYEAR() {
YEAR=$(echo "$DATE" | cut -d'-' -f1)
}
setMONTH() {
MONTH=$(echo "$DATE" | cut -d'-' -f2)
}
setDAY() {
MONTH=$(echo "$DATE" | cut -d'-' -f3)
}
setTIME() {
TIME=$(stat "$1" | grep Modify | cut -d' ' -f3)
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
set "$(exiv2 -g Exif.Image.DateTime -Pv "$1")"
	if [[ $? -eq 0 ]]; then
		YEAR="$1"
		MONTH="$2"
		DAY="$3"
		HOUR="$4"
		MINUTE="$5"
		SECOND="$6"
		MAKE=$(exiv2 -g Exif.Image.Make -Pv "$1")
		MODEL=$(exiv2 -g Exif.Image.Model -Pv "$1")		
 	else
		setDATE "$1"
		setTIME "$1"
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
echo -e "\tDirectory : ""$1" >> "$LOG"
}
logFile() {
echo "File : ""$1"" ""$DATE"" ""$TIME"" ""$MAKE"" ""$MODEL" >> "$LOG"
}
logCopy() {
if [[ "$FORCE" == "0" ]]; then
	echo "$1"" copied to ""$2" >> "$LOG"
else
	echo "$1"" moved to ""$2" >> "$LOG"
fi
}
copyFile() {
TARGET="$TEMP/$YEAR"
if [ ! -d "$TARGET" ]; then
	mkdir "$TARGET"
fi
TARGET="$TARGET/$MONTH"
if [ ! -d "$TARGET" ]; then
	mkdir "$TARGET"
fi
TARGET="$TARGET/$DAY"
if [ ! -d "$TARGET" ]; then
	mkdir "$TARGET"
fi
NAME="$YEAR""-""$MONTH""-""$DAY""_""$HOUR""-""$MINUTE""-""$SECOND""_""$MAKE""_""$MODEL"
local counter=1
while [ -e "$TARGET"/"$NAME" ];do
	NAME="$NAME""-""$counter"
	((counter++))
done
NAME+="$EXTENSION"
cp "$1" "$TARGET"/"$NAME"
logCopy "$1" "$TARGET"/"$NAME"
if [[ "$EXTENSION" == ".jpg" ]]; then
	echo "Copying ""$NAME"" - File ""$CURRENTJPG"" out of ""$JPGTOTAL"
	((CURRENTJPG++))
else
	echo "Copying ""$NAME"" - File ""$CURRENTVID"" out of ""$VIDTOTAL"
	((CURRENTVID++))
fi
}
copyTemp() {
mv "$TEMP" "$HOMEDIR"
}
eraseSource() {
echo "The script has organized and copied your files."
echo "It will now delete the original files to save space. "
echo "Are you absolutely sure that you want to delete ""$SOURCE""?(Y|N)"
read why_en
why_en=${why_en^^}
if [ "$why_en" == "Y" ]; then
	rm -rf "$SOURCE"
fi
}
