#!/usr/bin/bash

set -ouex pipefail

mkdir /var/opt
ln -s /var/opt /opt
dnf5 install -y \
    avahi \
    cloudflare-warp
