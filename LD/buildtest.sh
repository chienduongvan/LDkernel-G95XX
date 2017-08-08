#!/bin/bash
# LDkernel for Samsung Galaxy S8 & S8+ build script by chienduongvan

##################### VARIANTS #####################
#
# xx   = International Exynos 
#        SM-G950F, SM-G950FD, SM-G950N
#        SM-G955F, SM-G955FD, SM-G955N

####################################################

ARCH=arm64
MODEL=dream2lte
MODEl2=G955F
VARIANT=eur
KERNEL_DEFCONFIG=exynos8895-dream2lte_eur_open_defconfig

BUILD_CROSS_COMPILE=/home/chien/ldkernel/toolchian/aarch64-linux-android-4.9/bin/aarch64-linux-android-
BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`

export PATH=$(pwd)/bin:$PATH
export KERNEL_VERSION=$(cat version)
export KERNEL_NAME=$(cat kernelname)
export MODEl1=$(cat model)
export LOCALVERSION=-${KERNEL_NAME}-${MODEl2}-${KERNEL_VERSION}
export LD_ZIP=${KERNEL_NAME}-${MODEl1}-${KERNEL_VERSION}
export KBUILD_BUILD_USER="chienduongvan"
export KBUILD_BUILD_HOST="outlook.com"

RDIR=$(pwd)
BUILD_KERNEL_DIR=$RDIR/..
BUILD_KERNEL_OUT_DIR=$RDIR/output
KERNEL_IMG=$BUILD_KERNEL_OUT_DIR/arch/$ARCH/boot/Image
DTC=$BUILD_KERNEL_OUT_DIR/scripts/dtc/dtc
DTBOUTDIR=$BUILD_KERNEL_OUT_DIR/arch/$ARCH/boot/dt.img
DTBDIR=$BUILD_KERNEL_OUT_DIR/arch/$ARCH/boot/dtb
DTSDIR=$BUILD_KERNEL_DIR/arch/$ARCH/boot/dts/exynos
INCDIR=$BUILD_KERNEL_DIR/include
PAGE_SIZE=2048
DTB_PADDING=0

FUNC_PAUSE()
{
   read -p "$*"
}


FUNC_BUILD_KERNEL()
{
	echo ""
        echo "=============================================="
        echo "START : FUNC_BUILD_KERNEL"
        echo "=============================================="
        echo ""
        echo "build model="$MODEL""
        echo "build common config="$KERNEL_DEFCONFIG ""
	
	make -C $BUILD_KERNEL_DIR O=$BUILD_KERNEL_OUT_DIR -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE || exit -1

	make -C $BUILD_KERNEL_DIR O=$BUILD_KERNEL_OUT_DIR -j$BUILD_JOB_NUMBER ARCH=$ARCH \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE || exit -1

	rm -f $BUILD_KERNEL_DIR/arch/$ARCH/configs/$KERNEL_DEFCONFIG
	echo ""
	echo "================================="
	echo "END   : FUNC_BUILD_KERNEL"
	echo "================================="
	echo ""
}



	echo ""
	echo "================================="
	echo "START : FUNC_BUILD_DREAM2LTE_EUR"
	echo "================================="
	echo ""
	(
    	START_TIME=`date +%s`
	FUNC_BUILD_KERNEL
    	END_TIME=`date +%s`
    	let "ELAPSED_TIME=$END_TIME-$START_TIME"
    	echo "Total compile time is $ELAPSED_TIME seconds"
	) 2>&1	 | tee -a ./build_${MODEL}_${VARIANT}.log
	
	echo ""
	echo "================================="
	echo "END   : FUNC_BUILD_DREAM2LTE_EUR"
	echo "================================="
	echo ""

