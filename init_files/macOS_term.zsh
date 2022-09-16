#! /bin/zsh

source macOS_common.zsh

# Check if preferred font is installed

system_profiler SPFontsDataType | grep 'BitstreamVeraSansMono' 1>/dev/null 2>/dev/null

if [[ $? != 0 ]]
then
	set -e
	print_if_verbose "Downloading and installing BitstreamVeraSansMono Nerd font locally..."
	mkdir /tmp/nerdfont
	wget -P '/tmp/nerdfont' 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/BitstreamVeraSansMono.zip'
	unzip -d /tmp/nerdfont/ BitstreamVeraSansMono.zip
	cp '/tmp/BitstreamVeraSansMono/BitstreamVera Sans Mono Nerd Font Complete Mono.tff' ~/Library/Fonts
	print_if_verbose "done!\n"
	rm -rf /tmp/nerdfont/
	set +e
fi

export ITERM="/Applications/iTerm.app"

if [[ ! -e $ITERM ]]
then
	ITERM="~/Applications/iTerm.app"
	if [[ ! -e $ITERM ]]
	then
		set -e
		print_if_verbose "Downloading and installing iTerm2 locally..."
		mkdir /tmp/iTerm
		wget -P /tmp/iTerm https://iterm2.com/downloads/stable/iTerm2-3_4_16.zip
		unzip -d /tmp/iTerm /tmp/iTerm/iTerm2-3_4_16.zip
		mv /tmp/iTerm/iTerm.app $ITERM
		print_if_verbose "Done!\n"
		print_if_verbose "Downloading Martyrshot's iTerm profile..."
		wget -P /tmp/iTerm $REMOTEHOST/iterm2-Default.json
		print_if_verbose "Done!\n"
		open /tmp/iTerm
		open iTerm.app
		read -rsp $'Once iTerm profile is installed, press Enter' -n1 KEY
		while [[ $KEY != '' ]]
		do
			read -rsp $'Once iTerm profile is installed, press Enter' -n1 KEY
		done
		rm -rf /tmp/iTerm
		set +e
	fi
fi

print_if_verbose "Setting up .zshrc\n"

if [[ -e ~/.zshrc ]]
then
	print_if_verbose "Found a pre-existing .zshrc. Relocating..."
	mv ~/.zshrc ~/.zshrc.old.$(date -u +%Y-%m-%dT%H:%M:%SZ)
	print_if_verbose "Done!\n"
fi
which thefuck 1>/dev/null 2>/dev/null
if [[ $? == 0 ]]
then
	print_if_verbose "Adding crap alias..."
	echo "alias crap='fuck'" > ~/.zshrc
	print_if_verbose "Done!\n"
fi
which nvim 1>/dev/null 2>/dev/null
if [[ $? == 0 ]]
then
	print_if_verbose "Adding vim alias..."
	echo "alias vim='nvim'" >> ~/.zshrc
	print_if_verbose "Done!\n"
fi
which lsd 1>/dev/null 2>/dev/null
if [[ $? == 0 ]]
then
	print_if_verbose "Adding ls alias..."
	echo "alias ls='lsd'" >> ~/.zshrc
	print_if_verbose "Done!\n"
fi
which starship 1>/dev/null 2>/dev/null
if [[ $? == 0 ]]
	print_if_verbose "Adding starship eval..."
	echo "eval \"$(starship init zsh)\"" >> ~/.zshrc
fi


