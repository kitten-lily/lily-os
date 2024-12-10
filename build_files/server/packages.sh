#!/usr/bin/bash

set -ouex pipefail

/ctx/build_files/shared/docker-ce.sh

mkdir /var/opt
ln -s /var/opt /opt
dnf5 install -y \
    avahi \
    cloudflare-warp
