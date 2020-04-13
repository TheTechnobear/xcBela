#!/bin/bash
set -e
BASEDIR=$(dirname "$0")
export XC_IP=${XC_IP:=192.168.7.2}
export XC_ROOT=${XC_ROOT:="`realpath $BASEDIR/..`"}

cd "$XC_ROOT"

echo copying main libraries- takes a while

rsync -rzLR --safe-links \
      root@$XC_IP:/usr/lib/arm-linux-gnueabihf \
      root@$XC_IP:/usr/lib/gcc/arm-linux-gnueabihf \
      root@$XC_IP:/usr/include \
      root@$XC_IP:/lib/arm-linux-gnueabihf \
      sysroot/ 
