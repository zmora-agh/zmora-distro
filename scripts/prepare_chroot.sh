#!/bin/bash

STAGE3_BASE=http://distfiles.gentoo.org/releases/amd64/autobuilds
ROOT_SSH_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL9J5nV3qihryewsUlBH///caAQ3zWAEjr3ZqTtLyvBd maxmati@leopardus'

rm -f zmora-judge.img
rm -f zmora-judge.img.gz
rm -rf build
mkdir -p build

set -e

echo "====================================Creating basic disk=================================="

fallocate -l 15G zmora-judge.img
echo '102400,;' | sfdisk zmora-judge.img

LOOP_DEV=`losetup -fP --show zmora-judge.img`
mkfs.ext4 ${LOOP_DEV}p1
mount ${LOOP_DEV}p1 build

STAGE3_FILE=`curl http://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64.txt | grep -v '^#' | cut -f 1 -d ' '`

STAGE3_URL="$STAGE3_BASE/$STAGE3_FILE"
curl -O $STAGE3_URL
tar xjpf stage3-*.tar.bz2 --xattrs --numeric-owner -C build/

mount -t proc /proc build/proc
mount --rbind /sys build/sys
mount --make-rslave build/sys
mount --rbind /dev build/dev
mount --make-rslave build/dev


echo "====================================Preparing basic config===================================="

cp chroot_scripts/* build/
cp data/fstab build/etc/fstab

echo "nameserver 8.8.8.8" > build/etc/resolv.conf

echo "Europe/Warsaw" > build/etc/timezone
echo "en_US.UTF-8 UTF-8" > build/etc/locale.gen
echo 'hostname="zmora-judge"' > build/etc/conf.d/hostname

mkdir -p build/root/.ssh
echo $ROOT_SSH_KEY > build/root/.ssh/authorized_keys

mkdir -p build/tmp

cp -r data build/tmp/

chroot build /bin/bash /prepare.sh

cat data/world > build/var/lib/portage/world

