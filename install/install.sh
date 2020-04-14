#!/bin/bash

BASEDIR=$(dirname "$0")
export XC_IP=${XC_IP:=192.168.7.2}
export XC_ROOT=${XC_ROOT:="`realpath $BASEDIR/..`"}
export XC_USER=${XC_USER:=root}
export XC_SSH=${XC_USER}@${XC_IP}

echo XC_IP : $XC_IP, XC_ROOT : $XC_ROOT, XC_USER $XC_USER

echo "export XC_IP=$XC_IP; export XC_ROOT=$XC_ROOT;export XC_USER=$XC_USER" > ~/.xcBela.config

ping -c 1 -t 1 $XC_IP >/dev/null 2>&1 
if [ $? -ne 0 ]; then
    echo WARNING: unable to connect to ${XC_IP}, check XC_IP?
    exit -1
fi

do_upgrade=0
while getopts "q?" opt
do
    case $opt in
    (u) do_upgrade=1 ;;
    (?) echo "-u = upgrade" && exit 1 ;;
    (*) printf "Illegal option '-%s'\n" "$opt" && exit 1 ;;
    esac
done

set -e

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


export BBB_HOSTNAME=$XC_IP


if [ $do_upgrade -eq 0 ]; then
  echo clone bela core from github
  git clone https://github.com/BelaPlatform/Bela.git || true
  cd Bela
  git checkout master

  git submodule update --init --recursive
  cd "$XC_ROOT"
else 
  git submodule update --recursive
fi


if [ $do_upgrade -eq 0 ]; then
  ./install/install_os.sh
fi

./install/install_bela.sh
