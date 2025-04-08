#!/bin/bash

set -ouex pipefail

### Cleanup
shopt -s extglob

rm -rf /var /boot
mkdir -p /boot /var

bootc container lint --fatal-warnings
