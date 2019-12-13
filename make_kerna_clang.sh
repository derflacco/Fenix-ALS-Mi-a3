#!/bin/bash
#
# Copyright © 2018, "Vipul Jha" aka "LordArcadius" <vipuljha08@gmail.com>
# Copyright © 2018, "penglezos" <panagiotisegl@gmail.com>
# Copyright © 2018, "reza adi pangestu" <rezaadipangestu385@gmail.com>
# Copyright © 2018, "beamguide" <beamguide@gmail.com>
# Customized by "DerFlacco" <paul89rulez@gmail.com>

BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
green='\e[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
purple='\e[0;35m'
white='\e[0;37m'

KERNEL_DIR=$PWD
REPACK_DIR=$KERNEL_DIR/zip
OUT=$KERNEL_DIR/output
ZIP_NAME="$VERSION"-"$DATE"
VERSION="Fenix"
DATE=$(date +%Y%m%d-%H%M)

export ARCH=arm64
export SUBARCH=arm64
export USE_CCACHE=1
make_zip()
{
                cd $REPACK_DIR
               # mkdir kernel
                #mkdir dtbs
                #cp $KERNEL_DIR/output/arch/arm64/boot/Image.gz $REPACK_DIR/kernel/
                rm $KERNEL_DIR/output/arch/arm64/boot/dts/qcom/modules.order
                #cp $KERNEL_DIR/output/arch/arm64/boot/dts/qcom/sd* $REPACK_DIR/dtbs/
                cp $KERNEL_DIR/output/arch/arm64/boot/Image.gz-dtb $REPACK_DIR/
		FINAL_ZIP="Als-${VERSION}-${DATE}.zip"
        zip -r9 "${FINAL_ZIP}" *
		cp *.zip $OUT
		rm *.zip
                rm -rf kernel
                rm -rf dtbs
		cd $KERNEL_DIR
		rm out/arch/arm64/boot/Image.gz-dtb
}

make clean && make mrproper
PATH="/home/derflacco/toolchains/aosp_clang/bin:/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/:/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_arm-linux-gnueabi/bin/:${PATH}"
make O=output ARCH=arm64 vendor/fenix_defconfig
make -j$(nproc --all) O=output ARCH=arm64 CC="ccache clang -fcolor-diagnostics -Qunused-arguments" CLANG_TRIPLE="aarch64-linux-gnu-" CROSS_COMPILE="/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-" CROSS_COMPILE_ARM32="/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi-"
PATH="/home/derflacco/toolchains/aosp_clang/bin:/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/:/home/derflacco/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_arm-linux-gnueabi/bin/:${PATH}"


make_zip

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
rm -rf zip/kernel
rm -rf zip/Image.gz-dtb
rm -rf zip/dtbs
echo -e ""
echo -e ""
echo -e "Be a good boi!"
echo -e ""
echo -e ""
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
