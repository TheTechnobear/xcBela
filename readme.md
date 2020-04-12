## goals

This project provides a simple to install and use cross compiler environment


- simple installation of cross compiling environment
e.g ./install.sh

- easy to workflow with target board
e.g xcCompileRun render.cpp

## requirements
supported OS are:
- macOS
- Linux (debian based e.g. deb/ubuntu)

it would be easy to add other linux variants
windows could probably be done using gnu/cygwin tools
however, I dont have the time.... but Im happy to accept pull requests from others :)



## installation
see [install.md](https://github.com/TheTechnobear/bela_client/blob/master/install.md)


## usage

installs and runs by default using 
location: `~/bela_client`
bela hostname : `192.168.7.2` , default for usb

you can override with environment variables, if using a different bela, or scripts placed somewhere else
e.g.

```
export XC_IP=salt.local
export XC_ROOT=~/projects/bela_client
```

## setup environment
```
. $XC_ROOT/config/belaSetEnv

```
usage note: . (dot) - do not run as a script directly 

## commands
xcExec remotecmd 
xcCopy localfile remotefile
xcCompile patch.cpp
xcRun patch
xcCompileRun patch.cpp


## using Bela tools


### Bela commands
the 'usual' bela command line scripts are also available (and on the path),
e.g. we can disable the ide with
```
ide.sh stop
```

### Accessing Bela IDE
my main intention is not to use the IDE for development so editing and compiling. but it still has a couple of useful features I will use

(assuming, Ive not display ide at that time ;)  ) 

#### Oscilloscope
this is available directly in a browser using 
http://bela.local/scope


we can do ths from the command line too:

macOS
```
open http://${XC_IP}/scope
```

Linux 
```
chromium-browser http://${XC_IP}/scope
```


#### Bela Patch GUI
bela now supports web user interfaces, these can be access in the browser using:
http://bela.local/gui

we can do ths from the command line too:

macOS
```
open http://${XC_IP}/gui
```

Linux 
```
chromium-browser http://${XC_IP}/gui
```


## Credits & Resources

article on cross-compiling on mac 
https://medium.com/@haraldfernengel/cross-compiling-c-c-from-macos-to-raspberry-pi-in-2-easy-steps-23f391a8c63

cross compile script from by Andrew Capon, can be found here:
https://github.com/AndrewCapon/OSXBelaCrossCompiler

Bela wiki on remote compilation with Eclipse
https://github.com/BelaPlatform/Bela/wiki/Compiling-Bela-projects-in-Eclipse

