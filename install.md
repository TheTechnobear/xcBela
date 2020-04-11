## general 

get bela client and scripts
```
cd ~
git clone https://github.com/thetechnobear/bela_client
cd bela_client
cd install
./install

```



## what does this install?

## macOS

the following is contained in scripts/install_maco.sh

#### install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### install clang etc
```
brew install arm-linux-gnueabihf-binutils llvm rsync coreutils
```

