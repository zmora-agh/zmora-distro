#!/bin/bash

export MAKEOPTS="-j12"
emerge -uDN @world
rc-update add sysklogd default
rc-update add cronie default
rc-update add sshd default
