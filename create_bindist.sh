#!/bin/bash

bash scripts/clean_chroot.sh

rm packages.tar

set -e

bash scripts/prepare_chroot.sh

chroot build /bin/bash /create_bin_packages.sh

tar cvf packages.tar -C build/usr/portage packages

bash scripts/clean_chroot.sh

