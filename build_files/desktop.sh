#!/usr/bin/env bash

set -euox pipefail

dnf5 copr enable -y pgdev/ghostty

dnf5 install -y \
    ghostty \
    headsetcontrol
