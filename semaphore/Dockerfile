# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG SEMAPHORE_VERSION BUILD_ARCH

# Install nginx
RUN apk add --no-cache nginx

# Download Semaphore
RUN \
    ARCH="${BUILD_ARCH}" && if [ "${ARCH}" = "aarch64" ]; then ARCH="arm64"; fi && \
    curl -o semaphore_${SEMAPHORE_VERSION}_linux_${ARCH}.tar.gz -L https://github.com/semaphoreui/semaphore/releases/download/v${SEMAPHORE_VERSION}/semaphore_${SEMAPHORE_VERSION}_linux_${ARCH}.tar.gz && \
    tar xf semaphore_${SEMAPHORE_VERSION}_linux_${ARCH}.tar.gz && \
    mv semaphore /usr/local/bin/

# Copy nginx configuration
COPY nginx.conf /etc/nginx/http.d/default.conf

# Copy the run script
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
