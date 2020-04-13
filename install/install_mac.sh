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
BOTDIR=~/Library/Caches/Homebrew

ls $BOTDIR/rsync* > /dev/null 2>&1
if [ $? -ne 0 ]; then 
    brew install rsync
else
    brew upgrade rsync
fi

ls $BOTDIR/coreutils* > /dev/null 2>&1
if [ $? -ne 0 ]; then 
    brew install coreutils
else
    brew upgrade coreutils
fi

ls $BOTDIR/arm-linux-gnueabihf-binutils* > /dev/null 2>&1
if [ $? -ne 0 ]; then 
    brew install arm-linux-gnueabihf-binutils
else
    brew upgrade arm-linux-gnueabihf-binutils
fi

ls $BOTDIR/llvm* > /dev/null 2>&1
if [ $? -ne 0 ]; then 
    brew install llvm
else
    brew upgrade llvm
fi



