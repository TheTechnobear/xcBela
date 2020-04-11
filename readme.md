This project creates a suitable environment for cross-compiling for Bela

supports macOS and linux (only)

## installation
see [install.md](https://github.com/TheTechnobear/bela_client/blob/master/install.md)


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

## setup environment
```
. $BELA_ROOT/config/belaSetEnv

```
note: .  - do not run as a script

## commands
belaCompile a.cpp
belaCompileRun a.cpp
belaRun a  


## other commands
the 'usual' bela command line scripts are also available (and on the path),
e.g. we can disable the ide with
```
ide.sh stop
```

## Accessing the IDE
my main intention is not to use the IDE for development so editing and compiling. but it still has a couple of useful features I will use

(assuming, Ive not display ide at that time ;)  ) 

### Oscilloscope
this is available directly in a browser using 
http://bela.local/scope


we can do ths from the command line too:

macOS
```
open http://${BELA_IP}/scope
```

Linux 
```
chromium-browser http://${BELA_IP}/scope
```


### Patch GUI
bela now supports web user interfaces, these can be access in the browser using:
http://bela.local/gui

we can do ths from the command line too:

macOS
```
open http://${BELA_IP}/gui
```

Linux 
```
chromium-browser http://${BELA_IP}/gui
```


## Credits & Resources

article on cross-compiling on mac 
https://medium.com/@haraldfernengel/cross-compiling-c-c-from-macos-to-raspberry-pi-in-2-easy-steps-23f391a8c63

cross compile script from by Andrew Capon, can be found here:
https://github.com/AndrewCapon/OSXBelaCrossCompiler

Bela wiki on remote compilation with Eclipse
https://github.com/BelaPlatform/Bela/wiki/Compiling-Bela-projects-in-Eclipse



