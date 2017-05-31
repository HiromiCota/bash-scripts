#!/bin/bash

exit(){
exit
}
cleanup(){
:
}
check_ip(){

}
check_email(){

}
check_pn(){

}
check_ccn(){

}
if [[ check_ip $1 ]]; then

elif [[ check_email $1 ]]; then

elif [[ check_pn $1 ]]; then

elif [[ check_ccn $1 ]]; then

else
	echo "I don't know what that is."

fi

