#!/bin/bash
#
#FENIX KERNA GOODBOI SCRIPT
#
# 

make clean && make mrproper
export USE_CCACHE=1
USE_CCACHE=1
CACHE_DIR=~/.ccache
KBUILD_BUILD_USER=Der.Flacco
KBUILD_BUILD_HOST=Flacco.Machine

PATH="/home/derflacco/toolchains/aosp_clang/bin:/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/:/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_arm-linux-gnueabi/bin/:${PATH}"
make O=out ARCH=arm64 vendor/fenix_defconfig
make -j$(nproc --all) O=out ARCH=arm64 CC="ccache clang -fcolor-diagnostics -Qunused-arguments" CLANG_TRIPLE="aarch64-linux-gnu-" CROSS_COMPILE="/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-" CROSS_COMPILE_ARM32="/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi-"
