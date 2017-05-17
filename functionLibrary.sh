syntax() {
if [[ "$2" == "-h" ]]; then
	case $1 in
		getYYMMDD|getMMDD|getYY|getMM|getDD)
			echo $1 " usage: "$1" file_name"
			;;
		newDir)	
			echo $1 " usage: "$1" directory_name"
			;;
	esac
fi
}

getYYMMDD() {
syntax $0 $1
local VAR=$(stat $1)
local VAR=${VAR#*Modify: }
local VAR=${VAR%% *}
echo $VAR
}

getMMDD() {
syntax $0 $1
local VAR=$(getYYMMDD $1)
local VAR=${VAR#*-}
echo $VAR
}

getYY() {
syntax $0 $1
local VAR=$(getYYMMDD $1)
local VAR=${VAR%%-*}
echo $VAR
}

getMM() {
syntax $0 $1
local VAR=$(getMMDD $1)
local VAR=${VAR%-*}
echo $VAR
}

getDD() {
syntax $0 $1
local VAR=$(getMMDD $1)
local VAR=${VAR#-*}
echo $VAR
}

newDir() {
syntax $0 $1
mkdir ~/$1
}

move() {
syntax $0 $1
if 
