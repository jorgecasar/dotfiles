#!/usr/bin/env bash

echo "Setting up your Mac..."

cd "$(dirname "${BASH_SOURCE}")";

# git pull origin main;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE.txt" \
		--exclude "LICENSES" \
		--exclude "custom" \
		--exclude "homebrew" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

# Homebrew
source ./homebrew/install.sh
brew cleanup

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
