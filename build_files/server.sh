#!/usr/bin/env bash

set -euox pipefail

/ctx/build_files/server/changes.sh
/ctx/build_files/server/repos.sh
/ctx/build_files/server/packages.sh
/ctx/build_files/server/cleanup.sh

rpm-ostree initramfs --enable --arg=--force-add --arg=tpm2-tss
