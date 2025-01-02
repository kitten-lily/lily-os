#!/usr/bin/env bash

set -euox pipefail

# Tailscale
dnf config-manager --add-repo https://pkgs.tailscale.com/stable/centos/9/tailscale.repo
dnf config-manager --set-disabled tailscale-stable
