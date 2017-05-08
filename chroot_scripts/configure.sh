#!/bin/bash

set -e

etc-update --automode -5

echo 'GRUB_CMDLINE_LINUX="net.ifnames=0"' >> /etc/default/grub

cd /etc/init.d
ln -s net.lo net.eth0
rc-update add net.eth0 default
cd /

rc-update add zmora-judge default

cp /tmp/data/zmora-judge-conf /etc/conf.d/zmora-judge

echo 'root:$z4t4n' | chpasswd
