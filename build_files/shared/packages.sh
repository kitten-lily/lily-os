#!/usr/bin/bash

set -ouex pipefail

/ctx/build_files/shared/docker-ce.sh

# github direct installs
/ctx/build_files/github-release-install.sh rclone/rclone amd64
