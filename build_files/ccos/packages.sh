#!/usr/bin/env bash

set -euox pipefail

# Incus
#     edk2-ovmf
#     genisoimage
#     incus-agent
#     incus-client
#     qemu-char-spice
#     qemu-device-display-virtio-vga
#     qemu-device-display-virtio-gpu
#     qemu-device-usb-redirect
#     qemu-img
#     qemu-kvm-core
#     swtpm

dnf -y install \
    incus \
    qemu-img \
    qemu-kvm-core


# Tailscale
dnf -y --enablerepo tailscale-stable install \
  tailscale
