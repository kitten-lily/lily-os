#!/usr/bin/env bash

set -euox pipefail

# EPEL
dnf -y install epel-release epel-next-release

# Incus
dnf -y copr enable neil/incus

# Tailscale
dnf config-manager --add-repo https://pkgs.tailscale.com/stable/centos/9/tailscale.repo
dnf config-manager --set-disabled tailscale-stable
