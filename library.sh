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
exit() {
exit
}
cleanup() {
:
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
export FAIL=0

}
