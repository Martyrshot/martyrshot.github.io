#! /bin/bash

if [[ $(uname -s) == "Darwin" ]]
then
	# We are on a mac
	mkdir /tmp/marty_init
	wget -P /tmp/marty_init https://martyrshot.run/scripts/init_files/manifest.txt
	wget -P /tmp/marty_init --input-file /tmp/marty_init/manifest.txt
	zsh -c ./tmp/marty_init/macOS_init.zsh
elif [[ $(uname -s) == "Linux" ]]
then
	# We are on Linux
	echo "Linux is coming soon, but just not yet."
else
	# We are on an unsupported OS
	echo "Unsupported OS. Have fun doing this by hand!"
fi
