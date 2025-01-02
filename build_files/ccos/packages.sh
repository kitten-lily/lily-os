#!/usr/bin/env bash

set -euox pipefail

# Tailscale
dnf -y --enablerepo tailscale-stable install \
  tailscale
