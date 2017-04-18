#!/bin/bash

set -e

etc-update --automode -5

cd /etc/init.d
ln -s net.lo net.eth0
rc-update add net.eth0 default
cd /

echo 'root:$z4t4n' | chpasswd
