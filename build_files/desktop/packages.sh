#!/usr/bin/env bash

set -euox pipefail

echo "Running desktop packages scripts..."
/ctx/build_files/desktop/1password.sh

/ctx/build_files/desktop/repos.sh

# Download packages that we can't get from repos repos.
## Proton Mail
wget https://proton.me/download/mail/linux/ProtonMail-desktop-beta.rpm -O /tmp/ProtonMail-desktop-beta.rpm
## Proton Pass
pass_url=$(wget -q -O- https://proton.me/download/PassDesktop/linux/x64/version.json | jq -r '.Releases | max_by(.ReleaseDate) | .File[] | select(.Identifier==".rpm (Fedora/RHEL)").Url')
wget $pass_url -O /tmp/ProtonPass.rpm

# TODO: Add Proton VPN when available for f40
dnf5 install -y \
    headsetcontrol \
    morewaita-icon-theme \
    /tmp/ProtonMail-desktop-beta.rpm \
    /tmp/ProtonPass.rpm \
