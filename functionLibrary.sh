getHelp() {
echo $0" has the following syntax:"
echo $0" -options <source directory> <target directory>"
echo "<source directory> defaults to current directory."
echo "<target directory> defaults to current user's home."
echo "Valid options:"
echo "-h Help (this message)"
echo "-f Force move (move files to new directories, instead of copying)"
echo "-s Specify source AND target directory"
exit
}

getOpts() {
RETURN=0
while [ "$1" != "" ]; do
	case $1 in
		-f )	RETURN=$((RETURN+1))
			shift
			;;
		-h )	getHelp
			shift
			RETURN=0				
			;;
		-s )	RETURN=$((RETURN+2))
			shift
			;;
		* )	
			exit
			;;
	esac			
done
return RETURN
}

getYYMMDD() {
local VAR=$(stat $1)
local VAR=${VAR#*Modify: }
local VAR=${VAR%% *}
echo $VAR
}

getMMDD() {
local VAR=$(getYYMMDD $1)
local VAR=${VAR#*-}
echo $VAR
}

getYY() {
local VAR=$(getYYMMDD $1)
local VAR=${VAR%%-*}
echo $VAR
}

getMM() {
local VAR=$(getMMDD $1)
local VAR=${VAR%-*}
echo $VAR
}

getDD() {
local VAR=$(getMMDD $1)
local VAR=${VAR#-*}
echo $VAR
}

quit() {
exit
}

cleanup() {
:
}

