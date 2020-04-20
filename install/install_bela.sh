#!/bin/bash
set -e
BASEDIR=$(dirname "$0")
export XC_IP=${XC_IP:=192.168.7.2}
export XC_ROOT=${XC_ROOT:="`realpath $BASEDIR/..`"}
export XC_USER=${XC_USER:=root}
export XC_SSH=${XC_USER}@${XC_IP}

export BBB_ADDRESS=$XC_SSH



do_upgrade=0
do_quick=0

while getopts "uq?" opt
do
    case $opt in
    (u) do_upgrade=1 ;;
    (q) do_quick=1 && do_upgrade=1 ;;
    (?) echo "-u = upgrade -q = quick" && exit 1 ;;
    (*) printf "Illegal option '-%s'\n" "$opt" && exit 1 ;;
    esac
done

export upgrade_opts=" "

if [ $do_quick -eq 0 ]; then
    upgrade_opts = " --no-frills "
fi

cd "$XC_ROOT"
# ./Bela/scripts/update_board -y $upgrade_opts

ssh $XC_SSH "cd Bela && make -f Makefile.libraries && rm lib/* && make lib"

cd "$XC_ROOT"

echo copying some additional files
#xenomai
mkdir -p ./sysroot/usr/xenomai/include
mkdir -p ./sysroot/usr/xenomai/lib
rsync -avz $XC_SSH:/usr/xenomai/include ./sysroot/usr/xenomai
rsync -avz $XC_SSH:/usr/xenomai/lib ./sysroot/usr/xenomai

#'missing'
rsync -avz $XC_SSH:/usr/lib/libNE10.* ./sysroot/usr/lib
rsync -avz $XC_SSH:/usr/lib/libmathneon.* ./sysroot/usr/lib

#bela
mkdir -p ./sysroot/root/Bela/include
mkdir -p ./sysroot/root/Bela/lib
rsync -avz $XC_SSH:/root/Bela/libraries ./sysroot/root/Bela
rsync -avz $XC_SSH:/root/Bela/include ./sysroot/root/Bela
rsync -avz $XC_SSH:/root/Bela/build/pru/pru_rtaudio_irq_bin.h ./sysroot/root/Bela/include
rsync -avz $XC_SSH:/root/Bela/build/pru/pru_rtaudio_bin.h ./sysroot/root/Bela/include
rsync -avz $XC_SSH:/root/Bela/lib ./sysroot/root/Bela

#alsa
mkdir -p ./sysroot/usr/include/alsa
rsync -avz $XC_SSH:/usr/include/alsa ./sysroot/usr/include

#usr/local
mkdir -p ./sysroot/usr/local/lib
mkdir -p ./sysroot/usr/local/include
rsync -avz $XC_SSH:/usr/local/include/prussdrv.h ./sysroot/usr/local/include
rsync -avz $XC_SSH:/usr/local/include/seasocks ./sysroot/usr/local/include
rsync -avz $XC_SSH:/usr/local/lib/libpd.* ./sysroot/usr/local/lib
rsync -avz $XC_SSH:/usr/local/lib/libseasocks.* ./sysroot/usr/local/lib
rsync -avz $XC_SSH:/usr/local/lib/libprussdrv.* ./sysroot/usr/local/lib
rsync -avz $XC_SSH:/usr/local/include/libpd ./sysroot/usr/local/include
rsync -avz $XC_SSH:/usr/local/lib/libpd.so* ./sysroot/usr/local/lib
