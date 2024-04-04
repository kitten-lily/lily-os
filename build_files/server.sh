#!/usr/bin/env bash

set -euox pipefail

/ctx/build_files/server/changes.sh
/ctx/build_files/server/packages.sh
