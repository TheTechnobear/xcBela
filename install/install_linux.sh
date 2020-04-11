#!/bin/bash

#install required tools

echo deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main  >> /etc/apt/sources.list`
echo deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main  >> /etc/apt/sources.list`

sudo wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
sudo apt-get install libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev llvm-10-doc llvm-10-examples llvm-10-runtime
sudo apt-get install clang-10 clang-tools-10 clang-10-doc libclang-common-10-dev libclang-10-dev libclang1-10 clang-format-10 python-clang-10
sudo apt-get install binutils-arm-linux-gnueabihf cpp-5-arm-linux-gnueabihf gcc-5-arm-linux-gnueabihf
sudo apt-get install linux-libc-dev-armhf-cross
# libc6-armhf-cross libc6-dev:arm64
#sudo apt-get install libtinfo-dev:armhf libncurses5:armhf libncurses5-dev:armhf

`

