# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG SEMAPHORE_VERSION BUILD_ARCH

# Download Semaphore
RUN \
    # Transform BUILD_ARCH: aarch64 -> arm64, keep other values unchanged
    ARCH="${BUILD_ARCH}" && if [ "${ARCH}" = "aarch64" ]; then ARCH="arm64"; fi && \
    curl -o semaphore_${SEMAPHORE_VERSION}_linux_${ARCH}.tar.gz -L https://github.com/semaphoreui/semaphore/releases/download/v${SEMAPHORE_VERSION}/semaphore_${SEMAPHORE_VERSION}_linux_${ARCH}.tar.gz && \
    tar xf semaphore_${SEMAPHORE_VERSION}_linux_${ARCH}.tar.gz && \
    mv semaphore /usr/local/bin/

# Copy root filesystem
COPY rootfs /
git remote add origin https://github.com/felixilgatto/addon-semaphore.git