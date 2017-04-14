#!/bin/bash

root=0
users=500

function findHome {
	if [[ -r "/etc/passwd" ]]; then
		path=$(cat "/etc/passwd" | grep "x:${UID}:")
		path=$(echo "$path" | sed 's/[^\/]*//' | cut -f1 -d":")
		echo "$path is your home directory."
		du -shk $path
	else
		echo "Error reading /etc/passwd."
	fi
}

if [[ "$UID" -eq "$root" ]]; then
	echo "Running this command as root is insecure."
	findHome
elif [[ "$UID" -lt $users ]]; then
	echo "Non-users don't have home directories."
else
	findHome
fi
