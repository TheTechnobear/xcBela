#!/bin/bash
set -e
BASEDIR=$(dirname "$0")
export XC_IP=${XC_IP:=192.168.7.2}
export XC_ROOT=${XC_ROOT:="`realpath $BASEDIR/..`"}
export BBB_ADDRESS=root@$XC_IP

#additional
cd "$XC_ROOT/Bela"
echo update bela lib
#ensure that we have the same version of Bela on host and remote
#cannot push straight to the branch as it is most likely the currently checkout
#branch
BRANCH=`git branch --show-current`
git push root@$XC_IP:Bela $BRANCH:tmp-$BRANCH
ssh root@$XC_IP "cd Bela && git checkout $BRANCH && git merge tmp-$BRANCH && git branch -D tmp-$BRANCH && make lib"

cd "$XC_ROOT"

echo copying some additional files
#xenomai
mkdir -p ./sysroot/usr/xenomai/include
mkdir -p ./sysroot/usr/xenomai/lib
rsync -avz root@$XC_IP:/usr/xenomai/include ./sysroot/usr/xenomai
rsync -avz root@$XC_IP:/usr/xenomai/lib ./sysroot/usr/xenomai

#'missing'
rsync -avz root@$XC_IP:/usr/lib/libNE10.* ./sysroot/usr/lib
rsync -avz root@$XC_IP:/usr/lib/libmathneon.* ./sysroot/usr/lib

#bela
mkdir -p ./sysroot/root/Bela/include
mkdir -p ./sysroot/root/Bela/lib
rsync -avz root@$XC_IP:/root/Bela/libraries ./sysroot/root/Bela
rsync -avz root@$XC_IP:/root/Bela/include ./sysroot/root/Bela
rsync -avz root@$XC_IP:/root/Bela/build/pru/pru_rtaudio_irq_bin.h ./sysroot/root/Bela/include
rsync -avz root@$XC_IP:/root/Bela/build/pru/pru_rtaudio_bin.h ./sysroot/root/Bela/include
rsync -avz root@$XC_IP:/root/Bela/lib ./sysroot/root/Bela
scp root@$XC_IP:./Bela/core/default_main.cpp sysroot/root/Bela/

#alsa
mkdir -p ./sysroot/usr/include/alsa
rsync -avz root@$XC_IP:/usr/include/alsa ./sysroot/usr/include

#usr/local
mkdir -p ./sysroot/usr/local/lib
mkdir -p ./sysroot/usr/local/include
rsync -avz root@$XC_IP:/usr/local/include/prussdrv.h ./sysroot/usr/local/include
rsync -avz root@$XC_IP:/usr/local/include/seasocks ./sysroot/usr/local/include
rsync -avz root@$XC_IP:/usr/local/lib/libpd.* ./sysroot/usr/local/lib
rsync -avz root@$XC_IP:/usr/local/lib/libseasocks.* ./sysroot/usr/local/lib
rsync -avz root@$XC_IP:/usr/local/lib/libprussdrv.* ./sysroot/usr/local/lib
rsync -avz root@$XC_IP:/usr/local/include/libpd ./sysroot/usr/local/include
rsync -avz root@$XC_IP:/usr/local/lib/libpd.so* ./sysroot/usr/local/lib
