source /etc/profile

emerge-webrsync
emerge --sync --quiet

eselect profile set hardened/linux/amd64/selinux

emerge --config sys-libs/timezone-data

locale-gen
eselect locale set en_US.utf8
env-update && source /etc/profile
