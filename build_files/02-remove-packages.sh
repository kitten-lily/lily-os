#!/bin/bash

set -ouex pipefail

mkdir /var/roothome

REMOVE_PACKAGES=(
    android-tools
    borgbackup
    cascadia-code-fonts
    cockpit-*
    code
    fedora-bookmarks
    firewall-config
    gnome-classic-session
    gnome-shell-extension-apps-menu
    gnome-shell-extension-caffeine
    gnome-shell-extension-dash-to-dock
    gnome-shell-extension-gsconnect.x86_64
    gnome-shell-extension-launch-new-instance
    gnome-shell-extension-places-menu
    gnome-shell-extension-search-light
    gnome-shell-extension-user-theme
    gnome-shell-extension-window-list
    gnome-shell-theme-yaru
    gnome-tour
    gnome-tweaks
    nautilus-gsconnect
    stress-ng
    virt-install
    virt-manager
    virt-viewer
    yaru-*
    google-go-mono-fonts
    gtk-murrine-engine
    htop
    httpd
    ibm-plex-mono-fonts
    input-remapper
    input-leap
    malcontent-control
    malcontent-ui-libs
    nvtop
    openssh-server
    podman-tui
    restic
    simple-scan
    solaar
    sysprof
    tmux
    toolbox
    ubuntu-family-fonts
    yelp
)

dnf -y remove "${REMOVE_PACKAGES[@]}" --no-autoremove
