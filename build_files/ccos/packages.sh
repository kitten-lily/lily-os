#!/usr/bin/env bash

set -euox pipefail

# Incus
dnf -y install \
    incus \
    virt-manager

# Tailscale
dnf -y --enablerepo tailscale-stable install \
  tailscale

# Docker
dnf -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
