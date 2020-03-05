#!/bin/bash

set -e

if [ ! -z "$PI_DEV" ]; then
	echo "pi development already set"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR

export TOOLCHAIN_DIR=$PWD/tools
WIRINGPI_DIR=wiringPi

WIRINGPI_SRC_DIR=wiringPi/wiringPi

WIRINGPI_LIB=wiringPi/wiringPi/libwiringPi.so

TOOLCHAIN_CMAKE=$PWD/toolchain.cmake

envsubst < toolchain-rpi.cmake > toolchain.cmake

PI_TOOLS_DIR=tools

if [ ! -d ${PI_TOOLS_DIR} ]; then
	git clone git://github.com/raspberrypi/tools.git
	cd tools
	git submodule update --init --recursive
	cd ..
fi

if [ ! -f ${WIRINGPI_LIB} ]; then
	rm -f $WIRINGPI_SRC_DIR/CMakeCache.txt
	rm -rf $WIRINGPI_SRC_DIR/CMakeFiles
	cp wiringpi-cmakelist.txt $WIRINGPI_SRC_DIR/CMakeLists.txt
	cd $WIRINGPI_SRC_DIR
	cmake . -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_CMAKE
	make
fi

