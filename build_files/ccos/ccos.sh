#!/usr/bin/env bash

set -euox pipefail

/ctx/build_files/ccos/fixes.sh
/ctx/build_files/ccos/repos.sh
/ctx/build_files/ccos/packages.sh
/ctx/build_files/ccos/services.sh
/ctx/build_files/shared/signing.sh

bootc container lint
