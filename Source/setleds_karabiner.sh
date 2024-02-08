#!/usr/bin/env bash

if [ $# != 1 ] && [ $# != 2 ]
then
    echo -e "Usage:\t$cmd <setleds argument> [No keyboard profile]"
    echo -e "\tThe second argument is optional and defaults to \"No keyboard\""
    echo -e "\tIt should be the name of a Karabiner profile that doesn't have a"
    echo -e "\tkeyboard associated with it"
    echo
    echo "Example: $cmd +num"
    echo "Example: $cmd +num \"My no keyboard profile\""
    exit 1
fi

cli="/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"
fullname=`realpath $0`
cwd=`dirname "$fullname"`
cmd=`basename "$fullname"`
def_profile=`"$cli" --show-current-profile-name`
set_led_arg=$1

no_kbd_profile="No keyboard"
if [ $# == 2 ]
then
    no_kbd_profile=$2
fi


IFS=$'\n' read -r -d '' -a profiles < <( "$cli" --list-profile-names && printf '\0' )

hasProfile () {
	for i in "${profiles[@]}"
	do
  	if [[ $i == $1 ]]
  	then
    		return 0
  	fi
	done

	return 1
}

setInLoop () {
	count=0
	while `$cwd/setleds $set_led_arg | fgrep -q -- ?num`
	do
		sleep 0.1
		count=$((count+1))
		if [[ $count == 20 ]]
		then
			return 1
		fi
	done
	
	return 0
}

exit_code=0
if hasProfile "$no_kbd_profile" 
then
	"$cli" --select-profile "$no_kbd_profile"
	if ! setInLoop
	then
		echo "Gave up waiting for setled command to work" >&2
		exit_code=1
	fi
	"$cli" --select-profile "$def_profile"
else
    echo "\"$no_kbd_profile\" is not a profile" >&2
    echo "Valid profiles are" >&2
    declare -p profiles >&2
    exit_code=1
fi

exit $exit_code
