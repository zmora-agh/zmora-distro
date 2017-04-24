set -e

source /etc/profile

emerge-webrsync
emerge --sync --quiet

mkdir /etc/portage/repos.conf
cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf
sed -i 's!^sync-uri.*$!sync-uri = rsync://portage.memleak.pl/gentoo-portage/!' /etc/portage/repos.conf/gentoo.conf

eselect profile set default/linux/amd64/13.0

emerge --config sys-libs/timezone-data

locale-gen
eselect locale set en_US.utf8
env-update && source /etc/profile
