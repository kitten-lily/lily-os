#!/usr/bin/env bash

set -euox pipefail

## Proton Mail
wget https://proton.me/download/mail/linux/ProtonMail-desktop-beta.rpm -O /tmp/ProtonMail-desktop-beta.rpm
## Proton Pass
pass_url=$(wget -q -O- https://proton.me/download/PassDesktop/linux/x64/version.json | jq -r '.Releases | max_by(.ReleaseDate) | .File[] | select(.Identifier==".rpm (Fedora/RHEL)").Url')
wget $pass_url -O /tmp/ProtonPass.rpm

dnf5 install -y \
    ghostty \
    headsetcontrol \
    genisoimage \
    incus{,-agent,-client}\
    umoci \
    swtpm \
    /tmp/ProtonMail-desktop-beta.rpm \
    /tmp/ProtonPass.rpm
