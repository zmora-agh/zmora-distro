#!/bin/bash

STAGE3_URL=http://gentoo.prz.rzeszow.pl/releases/amd64/autobuilds/current-stage3-amd64-hardened/stage3-amd64-hardened-20170406.tar.bz2
ROOT_SSH_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL9J5nV3qihryewsUlBH///caAQ3zWAEjr3ZqTtLyvBd maxmati@leopardus'

rm zmora-judge.img
rm zmora-judge.img.gz
rm -rf build
mkdir -p build

fallocate -l 20G zmora-judge.img
echo ';' | sfdisk zmora-judge.img

LOOP_DEV=`losetup -fP --show zmora-judge.img`
mkfs.ext4 ${LOOP_DEV}p1
mount ${LOOP_DEV}p1 build


curl -O $STAGE3_URL
tar xjpf stage3-*.tar.bz2 --xattrs --numeric-owner -C build/

mount -t proc /proc build/proc
mount --rbind /sys build/sys
mount --make-rslave build/sys
mount --rbind /dev build/dev
mount --make-rslave build/dev

cp prepare.sh build/
cp install_soft.sh build/
cp build_kernel.sh build/
cp data/fstab build/etc/fstab

echo "nameserver 8.8.8.8" > build/etc/resolv.conf

echo "Europe/Warsaw" > build/etc/timezone
echo "en_US.UTF-8 UTF-8" > build/etc/locale.gen
echo 'hostname="zmora-judge"' > build/etc/conf.d/hostname

mkdir -p build/root/.ssh
echo $ROOT_SSH_KEY > build/root/.ssh/authorized_keys

chroot build /bin/bash /prepare.sh

cat data/world > build/var/lib/portage/world

chroot build /bin/bash /install_soft.sh

cp data/kernel_config build/usr/src/linux/.config
chroot build /bin/bash /build_kernel.sh

chroot build /bin/bash -c "grub-install --target=i386-pc ${LOOP_DEV}p1"
chroot build /bin/bash -c "grub-mkconfig -o /boot/grub/grub.cfg"

umount -lf build/proc
umount -lf build/sys
umount -lf build/dev

umount -lf ${LOOP_DEV}p1
losetup -d $LOOP_DEV

gzip zmora-judge.img
