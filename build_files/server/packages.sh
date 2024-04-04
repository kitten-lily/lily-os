#!/usr/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Add rpmfusion
# Not installed by default on ucore
dnf5 install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm

### Install packages
dnf5 install -y intel-media-driver \
    libva libva-utils \
    fish \
    nu \
    zsh \
    bat eza fd-find fzf gh gitui micro ripgrep tealdeer zoxide

# github direct installs
/ctx/build_files/github-release-install.sh twpayne/chezmoi x86_64

### Add Starship
# Starship Shell Prompt
curl -Lo /tmp/starship.tar.gz "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz"
tar -xzf /tmp/starship.tar.gz -C /tmp
install -c -m 0755 /tmp/starship /usr/bin
