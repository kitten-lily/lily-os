#!/usr/bin/bash

set -ouex pipefail

dnf5 install -y \
    avahi \
    cloudflare-warp
