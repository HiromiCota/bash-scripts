#!/bin/bash

exit(){
exit
}
cleanup(){
:
}
trap quit SIGINT SIGTERM
trap cleanup EXIT
check_ip(){
egrep '^((25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)$' <<< "$1"
local VAR=$?
return "$VAR"
}
check_email(){
egrep -q '^([a-zA-Z0-9\+!#\$%&\?\{|\}\*=]+)([a-ZA-Z0-9\+!#\$%&\?\{|\}\*=\.]*)@([a-ZA-Z0-9\+!#\$%&\?\{|\}\*=]*)\.([a-ZA-Z0-9\+!#\$%&\?\{|\}\*=\.]+)([a-zA-Z0-9\+!#\$%&\?\{|/}\*=]*)([a-zA-Z]){2}$' <<< "$1"
local VAR=$?
return "$VAR";
}
check_pn(){
egrep -q '^([1]?)([-/(\.]?)([0-9]){3}([-\)\.]?)([0-9]){3}([-\.]?)([0-9]){4}$' <<< "$1"
local VAR=$?
return "$VAR"
}
check_ccn(){
egrep -q '^3([47])([0-9]){13}$|^6011([0-9]){12}([0-9]?){3}$|^622([0-9]){13}([0-9]?){3}$|^64([4-9])([0-9]){13}([0-9]?){3}$|^65([0-9]){14}([0-9]?){3}$|^2([2-6])([0-9]){13}$|^27([0-1])([0-9]){13}$|^2720([0-9]){12}$|^5([1-4])([0-9]){14}$|^4([0-9]){12}([0-9]?){6}$' <<< "$1"
local VAR=$?
return "$VAR"
}
if [[ $1 == "" ]]; then
	echo "Please enter a number as an argument."
	echo "Example: ./lab13.sh 1-234-567-1234"
elif check_ip $1; then
	echo "$1 is an IPv4 IP address."
elif check_email $1; then
	echo "$1 is (probably) an email address."
elif check_pn $1; then
	echo "$1 is a US phone number."
elif check_ccn $1; then
	echo "$1 is a credit card number (AMEX, Discover, Mastercard, or Visa)."
else
	echo "I don't know what "$1" is."
fi

