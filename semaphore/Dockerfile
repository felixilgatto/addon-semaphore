# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG SEMAPHORE_VERSION BUILD_ARCH

# Install Caddy by downloading the prebuilt binary (portable across bases)
RUN \
    ARCH="${BUILD_ARCH}" && if [ "${ARCH}" = "aarch64" ]; then ARCH="arm64"; fi && \
    CADDY_VER="2.6.4" && \
    curl -fsSL -o /tmp/caddy.tar.gz "https://github.com/caddyserver/caddy/releases/download/v${CADDY_VER}/caddy_${CADDY_VER}_linux_${ARCH}.tar.gz" && \
    tar -xzf /tmp/caddy.tar.gz -C /tmp && \
    mv /tmp/caddy /usr/local/bin/caddy && \
    chmod +x /usr/local/bin/caddy && \
    rm -f /tmp/caddy.tar.gz

# Download Semaphore
RUN \
    ARCH="${BUILD_ARCH}" && if [ "${ARCH}" = "aarch64" ]; then ARCH="arm64"; fi && \
    curl -o semaphore_${SEMAPHORE_VERSION}_linux_${ARCH}.tar.gz -L https://github.com/semaphoreui/semaphore/releases/download/v${SEMAPHORE_VERSION}/semaphore_${SEMAPHORE_VERSION}_linux_${ARCH}.tar.gz && \
    tar xf semaphore_${SEMAPHORE_VERSION}_linux_${ARCH}.tar.gz && \
    mv semaphore /usr/local/bin/

# Copy Caddy configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Copy the run script
COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT [ "/run.sh" ]
