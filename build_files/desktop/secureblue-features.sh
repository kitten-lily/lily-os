#!/usr/bin/bash

set -ouex pipefail

# Per-network MAC randomization
curl https://raw.githubusercontent.com/secureblue/secureblue/live/files/system/etc/NetworkManager/conf.d/rand_mac.conf \
    -o /etc/NetworkManager/conf.d/rand_mac.conf

# Lock down firewall
curl https://raw.githubusercontent.com/secureblue/secureblue/live/files/system/etc/firewalld/zones/FedoraWorkstation.xml \
    -o /etc/firewalld/zones/FedoraWorkstation.xml

# Configure chronyd to use Network Time Security (NTS)
curl https://raw.githubusercontent.com/secureblue/secureblue/live/files/system/etc/chrony.conf \
    -o /etc/chrony.conf
curl https://raw.githubusercontent.com/secureblue/secureblue/live/files/system/etc/sysconfig/chronyd \
    -o /etc/sysconfig/chronyd

# sudo timeout to 1min instead of 0min
curl https://raw.githubusercontent.com/secureblue/secureblue/live/files/system/etc/sudoers.d/timeout \
    -o /etc/sudoers.d/timeout

# Disable passwordless sudo for rpm-ostree install
curl https://raw.githubusercontent.com/secureblue/secureblue/live/files/system/usr/share/polkit-1/rules.d/org.projectatomic.rpmostree1.rules \
    -o /usr/share/polkit-1/rules.d/org.projectatomic.rpmostree1.rules
