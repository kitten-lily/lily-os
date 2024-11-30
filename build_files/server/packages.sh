#!/usr/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

dnf5 remove -y \
    WALinuxAgent-udev \
    adcli \
    abattis-cantarell-fonts.noarch \
    adobe-source-code-pro-fonts.noarch \
    afterburn \
    afterburn-dracut \
    cockpit-bridge \
    cockpit-networkmanager \
    cockpit-podman.noarch \
    cockpit-selinux.noarch \
    cockpit-system.noarch \
    nano \
    nano-default-editor \
    nfs-utils-coreos \
    open-vm-tools \
    podman \
    podman-compose \
    tmux

# dnf5 list --installed
dnf5 install -y \
    libvirt-client \
    libvirt-daemon-kvm \
    virt-install
