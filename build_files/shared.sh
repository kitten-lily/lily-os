#!/usr/bin/env bash

set -euox pipefail

/ctx/build_files/shared/packages.sh
/ctx/build_files/shared/secureblue-features.sh
/ctx/build_files/shared/branding.sh
/ctx/build_files/shared/signing.sh
