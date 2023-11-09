#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Bootstrap script for setting up a new OSX machine using x86_64 architecture. 

xcode-select -p || exit "XCode must be installed! (use the app store)"

# Uncomment if you want to only allow the script to run on x86_64 architecture	
#arch=$(uname -m)
#permitted_architecture="x86_64"

#if [ "$arch" != "$permitted_architecture" ]; then
#	echo "In order to install these applications use intel 64bit architecture"
#	echo "If you are on an M1/M2 mac, you can switch using the following command:"
#	echo "\$env /usr/bin/arch -x86_64 /bin/zsh --login"
#	echo "..exiting.."
#	exit 1
#fi


# homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

if hash brew &>/dev/null; then
	echo "Homebrew already installed. Getting updates..."
	brew update
	brew doctor
else
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


#install brew packages
echo "installing packages"
PACKAGES=(
	cask
	wget
	zsh
	olets/tap/zsh-abbr
	neovim
	glab
	pre-commit
	socat
	magic-wormhole
)
brew install "${PACKAGES[@]}"


#list of casks to install
CASKS=(
	iterm2
	rectangle
	raycast
	visual-studio-code
	postman
	zoom
	)

#install casks
echo "installing casks"
brew install --cask "${CASKS[@]}"


#install oh my zsh 
if [[ ! -f ~/.zshrc ]]; then
	echo ''
	echo '##### Installing oh-my-zsh...'
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

	cp ~/.zshrc ~/.zshrc.orig
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	chsh -s /bin/zsh
#fi


