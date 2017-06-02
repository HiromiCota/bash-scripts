#!/bin/bash

exit(){
exit
}
cleanup(){
:
}
check_ip(){
egrep '^((25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)$' <<< "$1"
local VAR=$?
return "$VAR"
}
check_email(){
egrep -q '^([a-zA-Z0-9\+!#\$%&\?\{|\}\*=]+)([a-ZA-Z0-9\+!#\$%&\?\{|\}\*=\.]*)@([a-ZA-Z0-9\+!#\$%&\?\{|\}\*=]*)\.([a-ZA-Z0-9\+!#\$%&\?\{|\}\*=\.]+)([a-zA-Z0-9\+!#\$%&\?\{|/}\*=])$' <<< "$1"
local VAR=$?
return "$VAR";
}
check_pn(){
egrep -q '^([0-9]+)([-]?)([\(]?)([-0-9\)]*)([0-9])$' <<< "$1"
local VAR=$?
return "$VAR"
}
check_ccn(){

local VAR=$?
return "$VAR"
}
if check_ip $1; then
	echo "$1 is an IPv4 IP address."
elif check_email $1; then
	echo "$1 is (probably) an email address."
elif check_pn $1; then
	echo "$1 is a phone number."
elif check_ccn $1; then
	echo "$1 is a credit card number."
else
	echo "I don't know what that is."

fi

