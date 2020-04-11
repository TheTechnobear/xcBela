#!/bin/bash

#install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

#install required tools
brew install arm-linux-gnueabihf-binutils llvm rsync coreutils

