#!/bin/bash

set -ouex pipefail

sudo systemctl enable coolercontrold

systemctl enable incus.socket
systemctl enable incus.service
systemctl enable incus-startup
