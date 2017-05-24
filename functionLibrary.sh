getHelp() {
echo "$0"" has the following syntax:"
echo "$0"" -options <source directory> <target directory>"
echo "<source directory> defaults to current directory."
echo "<target directory> defaults to current user's home."
echo "Valid options:"
echo "-h Help (this message)"
echo "-f Force move (move files to new directories, instead of copying)"
echo "-s Specify source AND target directory"
exit
}

getOpts() {
case $1 in
	-f )	return 1
		shift
		;;
	-h )	getHelp
		shift
		return -1	
		;;
	-s )	return 2
		shift
		;;
	-fs )	return 3
		;;
	* )	return 0
		;;
esac			
}

getYYMMDD() {
local VAR=$(stat $1)
VAR=${VAR#*Modify: }
VAR=${VAR%% *}
echo "$VAR"
}

getMMDD() {
local VAR=$(getYYMMDD $1)
VAR=${VAR#*-}
echo "$VAR"
}

getYY() {
local VAR=$(getYYMMDD $1)
VAR=${VAR%%-*}
echo "$VAR"
}

getMM() {
local VAR=$(getMMDD $1)
VAR=${VAR%-*}
echo "$VAR"
}

getDD() {
local VAR=$(getMMDD $1)
VAR=${VAR#*-}
echo "$VAR"
}

quit() {
exit
}

cleanup() {
if [ -d "$TEMP" ]; then
	rm -rf "$TEMP"
fi
}

