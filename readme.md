This project creates a suitable environment for cross-compiling for Bela


## installation
see install.md


## usage

installs and runs by default using 
location: `~/bela_client`
bela hostname : `192.168.7.2` , default for usb

you can override with environment variables, if using a different bela, or scripts placed somewhere else
e.g.

```
export BELA_IP=salt.local
export BELA_ROOT=~/projects/bela_client
```

## Credits & Resources

article on cross-compiling on mac 
https://medium.com/@haraldfernengel/cross-compiling-c-c-from-macos-to-raspberry-pi-in-2-easy-steps-23f391a8c63

cross compile script from by Andrew Capon, can be found here:
https://github.com/AndrewCapon/OSXBelaCrossCompiler

Bela wiki on remote compilation with Eclipse
https://github.com/BelaPlatform/Bela/wiki/Compiling-Bela-projects-in-Eclipse



