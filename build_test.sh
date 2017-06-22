#!/bin/bash
# Adapted For LD_kernel

export MODEL=dream2lte
export ARCH=arm64
BUILD_CROSS_COMPILE=/usr/local/toolchain/arm-eabi-4.9/bin/arm-eabi-
BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`

make ARCH=exynos8895-ld_defconfig
make -j$BUILD_JOB_NUMBER ARCH=$ARCH


