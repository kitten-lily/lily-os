#!/bin/bash

set -ouex pipefail

sed -i 's/ublue-os\/bluefin\/main\/\${FLATPAKS}/kitten-lily\/lily-os-new\/main\/\${FLATPAKS}/' /usr/share/ublue-os/just/60-custom.just

echo 'import? "/usr/share/ublue-os/just/70-lily.just"' >> /usr/share/ublue-os/justfile
