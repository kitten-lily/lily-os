#!/usr/bin/env bash

set -euox pipefail

cat <<EOF > /etc/yum.repos.d/cloudflare-warp.repo
[cloudflare-warp-stable]
name=cloudflare-warp-stable
baseurl=https://pkg.cloudflareclient.com/rpm
enabled=1
type=rpm
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://pkg.cloudflareclient.com/pubkey.gpg
EOF
