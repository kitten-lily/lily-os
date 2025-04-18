#!/bin/bash

mkdir /var/roothome

set -ouex pipefail

dnf -y group install cosmic-desktop cosmic-desktop-apps

# Cooler Control
dnf -y copr enable codifryed/CoolerControl
dnf -y install \
    coolercontrol \
    coolercontrol-liqctld
dnf copr disable codifryed/CoolerControl
