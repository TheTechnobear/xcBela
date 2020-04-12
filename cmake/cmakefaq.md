# cross compiling with cmake

CMake is great :) 
if has support for cross-compilation via toolchain

simply supply the relevant toolchain via DCMAKE_TOOLCHAIN_FILE as the first definition, 
you can still include other definitions

e.g.
```
cmake -DCMAKE_TOOLCHAIN_FILE=~/xcBela/cmake/bela-toolchain.cmake  -DBELA=on ..
```

there the toolchain is speficied as `-DCMAKE_TOOLCHAIN_FILE=~/xcBela/cmake/bela-toolchain.cmake`


note:
It may be some projects required small alterations due to slight differences, e.g. if they usually use GCC rather than CLANG

these can be coded around, handy features for this in cmake include:


```
if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  # clang specific
else ()
  # non clang
endif()
```

doing optional things for cross compilation
```
if (CMAKE_CROSSCOMPILING)
  # cross compiling
else ()
  # not cross compiling
endif()
```


more details about Cmake and toolchains can be found on cmake docs
[make-toolchains](https://cmake.org/cmake/help/v3.8/manual/cmake-toolchains.7.html)
