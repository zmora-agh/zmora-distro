set -e

source /etc/profile

emerge-webrsync

mkdir /etc/portage/repos.conf
cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf
sed -i 's!^sync-uri.*$!sync-uri = rsync://portage.memleak.pl/gentoo-portage/!' /etc/portage/repos.conf/gentoo.conf

emerge --sync --quiet

eselect profile set default/linux/amd64/13.0

emerge --config sys-libs/timezone-data

#locale-gen
eselect locale set en_US.utf8
env-update && source /etc/profile

echo "PORTAGE_BINHOST=\"http://bindist.zmora-agh.memleak.pl/packages\"
FEATURES=\"getbinpkg\"
" >> /etc/portage/make.conf

emerge --buildpkg dev-vcs/git

mkdir -p /etc/portage/repos.conf
cp /tmp/data/zmora-overlay.conf /etc/portage/repos.conf

emerge --sync --quiet

