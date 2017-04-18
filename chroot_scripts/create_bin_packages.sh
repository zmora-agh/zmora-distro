#!/bin/bash

export MAKEOPTS="-j4"
emerge -uDN --buildpkg @world
