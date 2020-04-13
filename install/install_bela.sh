#!/bin/bash
set -e
BASEDIR=$(dirname "$0")
export XC_IP=${XC_IP:=192.168.7.2}
export XC_ROOT=${XC_ROOT:="`realpath $BASEDIR/..`"}
export XC_SSH=${XC_SSH:=root@$XC_IP}
export BBB_ADDRESS=$XC_SSH

cd "$XC_ROOT/Bela"
echo update bela lib
#ensure that we have the same version of Bela on host and remote
#cannot push straight to the branch as it is most likely the currently checkout
#branch
BRANCH=`git branch --show-current`
git push $XC_SSH:Bela $BRANCH:tmp-$BRANCH
ssh $XC_SSH "cd Bela && git checkout $BRANCH && git merge tmp-$BRANCH && git branch -D tmp-$BRANCH && make lib"

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
scp $XC_SSH:./Bela/core/default_main.cpp sysroot/root/Bela/

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
