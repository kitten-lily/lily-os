#!/bin/bash

mkdir /var/roothome

set -ouex pipefail

dnf -y install --setopt=install_weak_deps=False \
   mkosi

# Cooler Control
dnf -y copr enable codifryed/CoolerControl
dnf -y install \
    coolercontrol \
    coolercontrol-liqctld
dnf copr disable codifryed/CoolerControl
