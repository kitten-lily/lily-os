#!/usr/bin/env bash

set -euox pipefail

# Ghossty
dnf5 copr enable -y pgdev/ghostty

# Proton VPN
cat <<EOF > /etc/yum.repos.d/protonvpn-stable.repo
#
# ProtonVPN stable release
#
[protonvpn-fedora-stable]
name = ProtonVPN Fedora Stable repository
baseurl = https://repo.protonvpn.com/fedora-\$releasever-stable
enabled = 1
gpgcheck = 1
repo_gpgcheck=0
gpgkey = https://repo.protonvpn.com/fedora-\$releasever-stable/public_key.asc
EOF
