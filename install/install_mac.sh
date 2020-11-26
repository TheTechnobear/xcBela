#!/bin/bash
set -e

#install homebrew
which brew > /dev/null 2>&1
if [ $? -ne 0 ]; then 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    brew update
fi

#install or upgrade required tools
# brew install unless already installed
brewIn() { if brew ls --versions "$1"; then brew upgrade "$1" ; else brew install "$1"; fi }

#install required tools
for PACKAGE in arm-linux-gnueabihf-binutils llvm rsync coreutils git
do
	brewIn $PACKAGE;
done
