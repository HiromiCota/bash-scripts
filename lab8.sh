#!/bin/bash

FILE="./addresses.csv"
STRING=$(tail -1 "$FILE")
STRING=$( echo "${STRING,,}" | sed 's/"//g' )

grab() {
echo ${STRING##*,}
}
junk() {
STRING=${STRING%,*}
}
WEBURL=$(grab)
junk
EMAIL=$(grab)
junk
WPHONE=$(grab)
junk
HPHONE=$(grab)
junk
ZIP=$(grab)
junk
STATEABR=$(grab)
junk
STATE=$(grab)
junk
CITY=$(grab)
junk
STREET=$(grab)
junk
COMPANY=$(grab)
junk
LNAME=$(grab)
junk
FNAME=$(grab)
echo "FNAME = $FNAME"
echo "WEBURL = $WEBURL"
