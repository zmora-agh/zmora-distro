#!/bin/bash

#cd /usr/src/linux
#make alldefconfig
#make -j9 all
#make install
set -e

genkernel --kernel-config=/kernel_config --makeopts=-j`nproc` all

