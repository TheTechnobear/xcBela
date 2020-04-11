#!/bin/bash

BASEDIR=$(dirname "$0")
export BELA_IP=${BELA_IP:=192.168.7.2}
export BELA_ROOT=${BELA_ROOT:="`realpath $BASEDIR/..`"}
export BBB_ADDRESS=root@$BELA_IP

echo BELA_IP : $BELA_IP, BELA_ROOT : $BELA_ROOT


do_quick=0
while getopts "q?" opt
do
    case $opt in
    (q) do_quick=0 ; do_quick=1 ;;
    (?) echo "-q = quick" && exit 1 ;;
    (*) printf "Illegal option '-%s'\n" "$opt" && exit 1 ;;
    esac
done

cd "$BELA_ROOT"

if [ $do_quick -eq 0 ]; then
    echo clone bela core from github
    git clone https://github.com/BelaPlatform/Bela.git
    cd Bela
    git checkout master

    git submodule update --init --recursive
    cd "$BELA_ROOT"
fi


# ./Bela/scripts/stop_running.sh
# ./Bela/scripts/ide.sh stop


echo bring in includes/headers from bela board
#main systemroot 


if [ $do_quick -eq 0 ]; then
    echo main files - takes a while

    rsync -rzLR --safe-links \
          root@$BELA_IP:/usr/lib/arm-linux-gnueabihf \
          root@$BELA_IP:/usr/lib/gcc/arm-linux-gnueabihf \
          root@$BELA_IP:/usr/include \
          root@$BELA_IP:/lib/arm-linux-gnueabihf \
          sysroot/ 
fi

#rsync -avz root@$BELA_IP:/usr/lib/arm-linux-gnueabihf/libsndfile.* ./sysroot/usr/lib/arm-linux-gnueabihf/
#rsync -avz root@$BELA_IP:/usr/lib/arm-linux-gnueabihf/libasound.* ./sysroot/usr/lib/arm-linux-gnueabihf/
#rsync -avz root@$BELA_IP:/usr/include/ne10 ./sysroot/usr/include
#rsync -avz root@$BELA_IP:/usr/include/math_neon.h ./sysroot/usr/include



#additional
echo update bela lib
ssh root@$BELA_IP make -C ./Bela lib


echo copying some additional files
#xenoami
mkdir -p ./sysroot/usr/xenomai/include
mkdir -p ./sysroot/usr/xenomai/lib
rsync -avz root@$BELA_IP:/usr/xenomai/include ./sysroot/usr/xenomai
rsync -avz root@$BELA_IP:/usr/xenomai/lib ./sysroot/usr/xenomai

#'missing'
rsync -avz root@$BELA_IP:/usr/lib/libNE10.* ./sysroot/usr/lib
rsync -avz root@$BELA_IP:/usr/lib/libmathneon.* ./sysroot/usr/lib

#bela
mkdir -p ./sysroot/root/Bela/include
mkdir -p ./sysroot/root/Bela/lib
rsync -avz root@$BELA_IP:/root/Bela/include ./sysroot/root/Bela
rsync -avz root@$BELA_IP:/root/Bela/build/pru/pru_rtaudio_irq_bin.h ./sysroot/root/Bela/include
rsync -avz root@$BELA_IP:/root/Bela/build/pru/pru_rtaudio_bin.h ./sysroot/root/Bela/include
rsync -avz root@$BELA_IP:/root/Bela/lib ./sysroot/root/Bela
scp root@$BELA_IP:./Bela/build/core/default_main.o ./sysroot/root/Bela

#alsa
mkdir -p ./sysroot/usr/include/alsa
rsync -avz root@$BELA_IP:/usr/include/alsa ./sysroot/usr/include

#usr/local
mkdir -p ./sysroot/usr/local/lib
mkdir -p ./sysroot/usr/local/include
rsync -avz root@$BELA_IP:/usr/local/include/prussdrv.h ./sysroot/usr/local/include
rsync -avz root@$BELA_IP:/usr/local/include/seasocks ./sysroot/usr/local/include
rsync -avz root@$BELA_IP:/usr/local/lib/libpd.* ./sysroot/usr/local/lib
rsync -avz root@$BELA_IP:/usr/local/lib/libseasocks.* ./sysroot/usr/local/lib
rsync -avz root@$BELA_IP:/usr/local/lib/libprussdrv.* ./sysroot/usr/local/lib
rsync -avz root@$BELA_IP:/usr/local/include/libpd ./sysroot/usr/local/include
rsync -avz root@$BELA_IP:/usr/local/lib/libpd.so* ./sysroot/usr/local/lib

echo done

 
