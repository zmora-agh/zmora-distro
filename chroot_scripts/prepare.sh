source /etc/profile

emerge-webrsync
emerge --sync --quiet

eselect profile set default/linux/amd64/13.0

emerge --config sys-libs/timezone-data

locale-gen
eselect locale set en_US.utf8
env-update && source /etc/profile
