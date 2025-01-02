#!/usr/bin/env bash

set -euox pipefail

/ctx/build_files/shared/branding.sh
/ctx/build_files/shared/signing.sh

mv /var/lib/alternatives /staged-alternatives
ostree container commit
mkdir -p /var/lib
mv /staged-alternatives /var/lib/alternatives
mkdir -p /var/tmp
chmod -R 1777 /var/tmp
