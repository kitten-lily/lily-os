#!/usr/bin/bash

set -eoux pipefail

if [[ "${IMAGE}" =~ cosmic|ucore ]]; then
    tee /usr/share/ublue-os/image-info.json <<'EOF'
{
  "image-name": "",
  "image-flavor": "",
  "image-vendor": "kitten-lily",
  "image-ref": "ostree-image-signed:docker://ghcr.io/kitten-lily/lily-os",
  "image-tag": "",
  "base-image-name": "",
  "fedora-version": ""
}
EOF
fi

case "${IMAGE}" in
"bazzite"*|"bluefin"*)
    base_image="silverblue"
    ;;
"aurora"*)
    base_image="kinoite"
    ;;
"cosmic"*)
    base_image="${BASE_IMAGE}"
    ;;
"ucore"*)
    base_image="${BASE_IMAGE}"
    ;;
esac

image_flavor="main"
if [[ "$IMAGE" =~ nvidia ]]; then
    image_flavor="nvidia"
fi

# Branding
cat <<<"$(jq ".\"image-name\" |= \"lily-os\" |
              .\"image-flavor\" |= \"${image_flavor}\" |
              .\"image-vendor\" |= \"kitten-lily\" |
              .\"image-ref\" |= \"ostree-image-signed:docker://ghcr.io/kitten-lily/lily-os\" |
              .\"image-tag\" |= \"${IMAGE}${BETA:-}\" |
              .\"base-image-name\" |= \"${base_image}\" |
              .\"fedora-version\" |= \"$(rpm -E %fedora)\"" \
    </usr/share/ublue-os/image-info.json)" \
>/tmp/image-info.json
cp /tmp/image-info.json /usr/share/ublue-os/image-info.json

if [[ "$IMAGE" =~ bazzite ]]; then
    sed -i 's/image-branch/image-tag/' /usr/libexec/bazzite-fetch-image
fi
