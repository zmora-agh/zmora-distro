#!/bin/bash

umount -lf build/proc
umount -lf build/sys
umount -lf build/dev

umount -lf build
losetup -D

rm -rf build
rm stage3-*.tar.bz2
