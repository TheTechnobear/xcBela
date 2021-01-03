#!/bin/bash
set -e

#install required tools
DISTRO=$(grep DISTRIB_ID /etc/*-release | cut -d "=" -f2-)

case "$DISTRO" in
    "Arch") echo "Pacman"
            sudo pacman -S \
                llvm llvm-libs llvm-ocaml \
                clang \
                arm-none-eabi-binutils arm-none-eabi-gcc arm-none-eabi-newlib
        ;;
    "Ubuntu"|"Debiuan") echo "Deb"
            sudo apt-get install \
                libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev \
                llvm-10-doc llvm-10-examples llvm-10-runtime \
                clang-10 clang-tools-10 clang-10-doc \
                libclang-common-10-dev libclang-10-dev libclang1-10 clang-format-10 \
                binutils-arm-linux-gnueabihf cpp-5-arm-linux-gnueabihf gcc-5-arm-linux-gnueabihf \
                linux-libc-dev-armhf-cross
        ;;
esac
