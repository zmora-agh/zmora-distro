#!/bin/bash

export MAKEOPTS="-j12"
emerge -uDN --buildpkg @world
