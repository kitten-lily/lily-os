#!/bin/bash

set -ouex pipefail

sudo systemctl enable coolercontrold

systemctl disable docker.socket
systemctl disable docker.service
systemctl enable incus.socket
systemctl enable incus.service
systemctl enable incus-startup
