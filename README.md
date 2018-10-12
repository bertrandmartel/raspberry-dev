# Raspberry PI developement environment

A quick development environment to develop for Raspberry PI on your PC based on [this guide](https://medium.com/@au42/the-useful-raspberrypi-cross-compile-guide-ea56054de187). A standalone bash script download the toolchain and build [wiringPi](http://wiringpi.com/) library using cmake.

It can be included as a submodule like this : 

```bash
cd project_dir
git submodule add git://github.com/bertrandmartel/raspberry-dev.git
git submodule update --init --recursive
```

Then, create your CMakeLists.txt in your project directory and execute : 

```bash
./raspberry-dev/init.sh
cmake . -DCMAKE_TOOLCHAIN_FILE=./raspberry-dev/toolchain.cmake
make
```

Note: toolchain can be changed in `toolchain-rpi.cmake`

## License

The MIT License (MIT) Copyright (c) 2018 Bertrand Martel