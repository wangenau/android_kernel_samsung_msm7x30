#!/bin/bash

DEFCONFIG_FILE=$1

if [ -z "$DEFCONFIG_FILE" ]; then
	echo "Need defconfig file(j1v-perf_defconfig)!"
	exit -1
fi

if [ ! -e arch/arm/configs/$DEFCONFIG_FILE ]; then
	echo "No such file : arch/arm/configs/$DEFCONFIG_FILE"
	exit -1
fi

# make .config
env KCONFIG_NOTIMESTAMP=true \
make ARCH=arm CROSS_COMPILE=arm-eabi- ${DEFCONFIG_FILE}

# copy .config to defconfig
mv .config arch/arm/configs/${DEFCONFIG_FILE}
# clean kernel object
make mrproper
