#!/bin/bash

BASEDIR=$(dirname "$0")
export XC_IP=${XC_IP:=192.168.7.2}
export XC_ROOT=${XC_ROOT:="`realpath $BASEDIR/..`"}
export BBB_ADDRESS=root@$XC_IP

echo XC_IP : $XC_IP, XC_ROOT : $XC_ROOT


do_upgrade=0
while getopts "q?" opt
do
    case $opt in
    (u) do_upgrade=0 ; do_upgrade=1 ;;
    (?) echo "-u = upgrade" && exit 1 ;;
    (*) printf "Illegal option '-%s'\n" "$opt" && exit 1 ;;
    esac
done


cd "$XC_ROOT"

#install tools
if [ $do_upgrade -eq 0 ]; then
  PLATFORM=`uname`
  if [ "${PLATFORM}" = "Darwin" ]; then
    echo install mac tools
    ${XC_ROOT}/install/install_mac.sh
  else
    echo install linux tools
    ${XC_ROOT}/install/install_linux.sh
  fi 
fi


if [ $do_upgrade -eq 0 ]; then
  echo clone bela core from github
  git clone https://github.com/BelaPlatform/Bela.git
  cd Bela
  git checkout master

  git submodule update --init --recursive
  cd "$XC_ROOT"
else 
  git submodule update --recursive
fi


if [ $do_upgrade -eq 0 ]; then
  ./install/install_os.sh
  #rsync -avz root@$XC_IP:/usr/lib/arm-linux-gnueabihf/libsndfile.* ./sysroot/usr/lib/arm-linux-gnueabihf/
  #rsync -avz root@$XC_IP:/usr/lib/arm-linux-gnueabihf/libasound.* ./sysroot/usr/lib/arm-linux-gnueabihf/
fi

./install/install_bela.sh

 
