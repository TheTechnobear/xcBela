## General 

the installation is very staightforward, and does 


## requirements
supported OS are:
- macOS
- Linux (debian based e.g. deb/ubuntu)

it would be easy to add other linux variants
windows could probably be done using gnu/cygwin tools
however, I dont have the time.... but Im happy to accept pull requests from others :)


see specific requirements below, in addition

- computer (not bela) must be connected to the internet to download packages
- computer must be connected to bela

connection to bela...

if you are connected via USB to bela, and you can ping on 192.168.7.2, then you are good to go :) 

if you have configure bela for networking over wifi/ethernet or are using a different IP address, 
you must set the XC_IP address according 

e.g. 
```
export XC_IP=pepper.local
```

make sure you can successfully log on to bela with this,
e.g.
```
ssh root@$XC_IP
```


## Installing on Mac OS 
get bela client and scripts
```
cd ~
git clone https://github.com/thetechnobear/bela_client
cd bela_client
cd install
./install
```

### information only:
the mac installation uses homebrew to install llvm an some other tools using...
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install arm-linux-gnueabihf-binutils llvm rsync coreutils
```


## Installing on Linux

Note: currently im only supporting debian (using apt), though its trival to change the install scripts for other distros, 
should be simply a matter of replacing apt-get to with pacman or whatever your distro provides
(if make it work on another disto, please send me a PR with changes)


linux is a litte more involved as before we start running the install we must manually configure apt/deb  to pick up packages from them LLVM repository

these are listed here: https://apt.llvm.org/

(we are installing the stable branch of llvm-10)

we need to add to /etc/apt/sources.list , 2 lines 
which depends on the version of ubuntu you are using, e.g. for bionic, we add the following two lines:

```
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main`
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main `
```

once we have done this we need to add the llvm key, to authorise, and then update apt

```
sudo wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
sudo apt update
```

Now we are ready to do the install :) 

```
cd ~
git clone https://github.com/thetechnobear/bela_client
cd bela_client
cd install
./install
```

## information only

what does this install?
basically llvm, clang and binary packages associate with gnueabihf

sudo apt-get install libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev llvm-10-doc llvm-10-examples llvm-10-runtime
sudo apt-get install clang-10 clang-tools-10 clang-10-doc libclang-common-10-dev libclang-10-dev libclang1-10 clang-format-10
sudo apt-get install binutils-arm-linux-gnueabihf cpp-5-arm-linux-gnueabihf gcc-5-arm-linux-gnueabihf
sudo apt-get install linux-libc-dev-armhf-cross


