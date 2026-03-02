#!/usr/bin/with-contenv bashio
# ==============================================================================
# Start the example service
# s6-overlay docs: https://github.com/just-containers/s6-overlay
# ==============================================================================

export SEMAPHORE_PORT=3000

export SEMAPHORE_COOKIE_HASH=$(head -c32 /dev/urandom | base64)
export SEMAPHORE_COOKIE_ENCRYPTION=$(head -c32 /dev/urandom | base64)
export SEMAPHORE_ACCESS_KEY_ENCRYPTION=$(head -c32 /dev/urandom | base64)

export SEMAPHORE_DB_DIALECT=sqlite
export SEMAPHORE_DB_HOST=./database.sqlite

semaphore user add --admin \
    --login $(bashio::config 'admin_login') \
    --password $(bashio::config 'admin_password') \
    --name $(bashio::config 'admin_name') \
    --email $(bashio::config 'admin_email') \
    --no-config

# Start Semaphore in the background
semaphore server --no-config &
SEMAPHORE_PID=$!

# Start Caddy in the foreground
caddy run --config /etc/caddy/Caddyfile

# If Caddy exits, kill Semaphore
kill $SEMAPHORE_PID 2>/dev/null || true