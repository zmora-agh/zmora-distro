#!/bin/bash

export MAKEOPTS="-j`nproc`"
emerge -uDN --buildpkg @world

