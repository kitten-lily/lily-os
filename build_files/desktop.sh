#!/usr/bin/env bash

set -euox pipefail

/ctx/build_files/desktop/packages.sh
/ctx/build_files/desktop/adwaita-colors.sh
/ctx/build_files/desktop/fixes.sh
/ctx/build_files/desktop/secureblue-features.sh
/ctx/build_files/desktop/cleanup.sh
