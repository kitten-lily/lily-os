# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ghcr.io/ublue-os/bluefin-dx:beta

### MODIFICATIONS
COPY system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    /ctx/01-flatpaks.sh

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/02-remove-packages.sh

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    /ctx/03-interface.sh

### CLEANUP & LINTING
## Clean up and verify final image and contents are correct.
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    /ctx/cleanup.sh
