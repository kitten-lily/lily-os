ARG BASE_IMAGE="bluefin"
ARG IMAGE="bluefin"
ARG TAG_VERSION="latest"

FROM scratch AS ctx
COPY / /
ADD --chmod=755 https://raw.githubusercontent.com/bsherman/bos/refs/heads/main/build_files/github-release-install.sh /build_files/github-release-install.sh
ADD --chmod=755 https://raw.githubusercontent.com/bsherman/bos/refs/heads/main/build_files/desktop-1password.sh /build_files/desktop/1password.sh
ADD --chmod=755 https://raw.githubusercontent.com/bsherman/bos/refs/heads/main/build_files/server-docker-ce.sh /build_files/shared/docker-ce.sh
ADD --chmod=755 https://raw.githubusercontent.com/bsherman/bos/refs/heads/main/build_files/server-changes.sh /build_files/server/changes.sh


FROM ghcr.io/ublue-os/${BASE_IMAGE}:${TAG_VERSION}

ARG BASE_IMAGE="bluefin"
ARG IMAGE="bluefin"

RUN --mount=type=bind,from=ctx,src=/,dst=/ctx \
    mkdir -p /var/lib/alternatives && \
    /ctx/build.sh && \
    mv /var/lib/alternatives /staged-alternatives && \
    ostree container commit && \
    mkdir -p /var/lib && mv /staged-alternatives /var/lib/alternatives && \
    mkdir -p /var/tmp && \
    chmod -R 1777 /var/tmp
