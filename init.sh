#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR

export TOOLCHAIN_DIR=$PWD/tools
WIRINGPI_DIR=wiringPi

WIRINGPI_SRC_DIR=wiringPi/wiringPi

WIRINGPI_LIB=wiringPi/wiringPi/libwiringPi.so

TOOLCHAIN_CMAKE=$PWD/toolchain.cmake

envsubst < toolchain-rpi.cmake > toolchain.cmake

if [ ! -f ${WIRINGPI_LIB} ]; then
	rm -f $WIRINGPI_SRC_DIR/CMakeCache.txt
	rm -rf $WIRINGPI_SRC_DIR/CMakeFiles
	cp wiringpi-cmakelist.txt $WIRINGPI_SRC_DIR/CMakeLists.txt
	cd $WIRINGPI_SRC_DIR
	cmake . -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_CMAKE
	make
fi

