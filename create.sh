#!/bin/bash

source scripts/prepare_chroot.sh

chroot build /bin/bash /install_soft.sh

cp data/kernel_config build/usr/src/linux/.config
chroot build /bin/bash /build_kernel.sh

chroot build /bin/bash -c "grub-install --target=i386-pc ${LOOP_DEV}"
chroot build /bin/bash -c "grub-mkconfig -o /boot/grub/grub.cfg"

bash scripts/clean_chroot.sh

#gzip zmora-judge.img
