#!/bin/bash

set -ouex pipefail

# Run vscode under wayland
if [ -f /usr/share/applications/code.desktop ]; then
    sed -i 's/--new/--ozone-platform-hint=auto --new/' /usr/share/applications/code.desktop
fi
