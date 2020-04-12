

message("using xc-bela-toolchain")
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(triple arm-linux-gnueabihf)

if(APPLE)
    set(CMAKE_C_COMPILER /usr/local/opt/llvm/bin/clang)
    set(CMAKE_CXX_COMPILER /usr/local/opt/llvm/bin/clang++)
    # set(tools /usr/local/opt/arm-linux-gnueabihf-binutils)
else()
    set(CMAKE_C_COMPILER /usr/bin/clang-10)
    set(CMAKE_CXX_COMPILER /usr/bin/clang++-10)
    # set(tools /usr/local/arm-linux-gnueabihf-binutils) ?
endif()

set(CMAKE_C_COMPILER_TARGET ${triple})
set(CMAKE_CXX_COMPILER_TARGET ${triple})

get_filename_component(XC_ROOT "~/xcBela" ABSOLUTE)
set(XC_SYSROOT ${XC_ROOT}/sysroot)
set(CMAKE_SYSROOT ${XC_SYSROOT})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I${XC_SYSROOT}/root/Bela -I${XC_SYSROOT}/root/Bela/include ")

set(BELA_LINK_FLAGS "${BELA_LINK_FLAGS} -L${XC_SYSROOT}/root/Bela/lib -L${XC_SYSROOT}/usr/local/lib -Wl,--no-as-needed -L${XC_SYSROOT}/usr/xenomai/lib" ) 
set(BELA_LINK_FLAGS "${BELA_LINK_FLAGS} -lprussdrv -lasound -lseasocks -lNE10 -lmathneon -ldl") 
set(BELA_LINK_FLAGS "${BELA_LINK_FLAGS} -lbela -lbelaextra") 
set(BELA_LINK_FLAGS "${BELA_LINK_FLAGS} -L${XC_SYSROOT}/usr/lib/gcc/arm-linux-gnueabihf/6.3.0  -B${XC_SYSROOT}/usr/lib/gcc/arm-linux-gnueabihf/6.3.0  -latomic")
set(BELA_LINK_FLAGS "${BELA_LINK_FLAGS} -Wl,-rpath-link,${XC_SYSROOT}/lib/arm-linux-gnueabihf")

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${BELA_LINK_FLAGS}")
set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} ${BELA_LINK_FLAGS}")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${BELA_LINK_FLAGS}")

# possibily useful?
# set(CMAKE_STAGING_PREFIX /home/devel/stage)
# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)



#bela-config for details
#note: most of these are in the main cmake file as conditions on -DBELA=on

#/root/Bela/resources/bin/bela-config --defines
#-DXENOMAI_SKIN_posix
#/root/Bela/resources/bin/bela-config --includes
#/root/Bela/include
#/root/Bela/resources/bin/bela-config --libraries
#-L/usr/xenomai/lib -L/root/Bela/lib -lbela -lcobalt -lmodechk -lpthread -lrt
#/root/Bela/resources/bin/bela-config --cflags
#-march=armv7-a -mtune=cortex-a8 -mfloat-abi=hard -mfpu=neon -ftree-vectorize -ffast-math
#/root/Bela/resources/bin/bela-config --cxxflags
#-march=armv7-a -mtune=cortex-a8 -mfloat-abi=hard -mfpu=neon -ftree-vectorize -ffast-math

