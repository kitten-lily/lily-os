#!/usr/bin/env bash

set -euox pipefail

systemctl enable podman.socket
systemctl enable rpm-ostreed-automatic.timer
systemctl enable tailscaled.service
systemctl disable auditd.service
