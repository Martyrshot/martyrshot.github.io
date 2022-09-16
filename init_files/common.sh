#! /bin/bash

export REMOTEHOST=https://martyrshot.github.io/scripts/
export INITDIR=init_files/

function print_if_verbose {
	if [[ -z $VERBOSE ]]
	then
		echo -n $1
	fi
}
