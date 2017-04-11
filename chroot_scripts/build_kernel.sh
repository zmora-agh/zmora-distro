#!/bin/bash

cd /usr/src/linux
make alldefconfig
make -j9 all
make install

