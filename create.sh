#!/bin/bash

bash scripts/clean_chroot.sh

source scripts/prepare_chroot.sh

chroot build /bin/bash /install_soft.sh

cp data/kernel_config build/kernel_config
chroot build /bin/bash /build_kernel.sh

chroot build /bin/bash /configure.sh

chroot build /bin/bash -c "grub-install --target=i386-pc ${LOOP_DEV}"
chroot build /bin/bash -c "grub-mkconfig -o /boot/grub/grub.cfg"


bash scripts/clean_chroot.sh

gzip zmora-judge.img
