#! /bin/zsh

source common.sh

# Install commandline-tools
sudo xcode-select --install

set -e
# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tools
print_if_verbose "Getting Brewfile and installing tools based on it\n"
mkdir /tmp/tools
wget -P /tmp/tools $REMOTEHOST/$INITDIR/Brewfile
brew bundle install --file /tmp/tools/Brewfile
brew update
brew upgrade
brew cleanup

# Get nvim files
mkdir -p ~/.config
mkdir -p ~/.config/nvim
if [[ -e ~/.config/nvim/init.vim ]]
then
	print_if_verbose "Found a pre-existing init.vim. Relocating..."
	mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.old.$(date -u +%Y-%m-%dT%H:%M:%SZ)
	print_if_verbose "Done!\n"
fi
wget -P ~/.config/nvim $REMOTEHOST/$INITDIR/init.vim
echo "Please use the command \`:PlugInstall\`" > /tmp/tmp.vim
nvim /tmp/tmp.vim
rm /tmp/tmp.vim
set +e
