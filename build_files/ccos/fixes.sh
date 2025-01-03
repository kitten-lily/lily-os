#!/usr/bin/env bash

set -euox pipefail

# See https://github.com/centos-workstation/achillobator/issues/3
mkdir -m 0700 -p /var/roothome
# Fast track https://gitlab.com/fedora/bootc/base-images/-/merge_requests/71
ln -sf /run /var/run
# Required for Logically Bound images, see https://gitlab.com/fedora/bootc/examples/-/tree/main/logically-bound-images/usr/share/containers/systemd
ln -sr /etc/containers/systemd/*.container /usr/lib/bootc/bound-images.d/

# Remove "old" docker packages
dnf remove docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-engine
