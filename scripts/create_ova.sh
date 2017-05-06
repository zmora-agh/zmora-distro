#!/bin/bash
set -e

qemu-img convert -f raw -O vmdk zmora-judge.img ova/zmora-disk001.vmdk
tar cvf zmora.ova -C ova zmora.ovf zmora-disk001.vmdk 
pigz zmora.ova
