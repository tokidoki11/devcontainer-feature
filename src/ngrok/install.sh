#!/bin/bash
set -e

NGROK_VERSION="${VERSION:-"latest"}"

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
    x86_64) NGROK_ARCH="amd64" ;;
    aarch64 | arm64) NGROK_ARCH="arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Map "latest" to "stable" for the equinox download URL
if [ "$NGROK_VERSION" = "latest" ]; then
    NGROK_VERSION="stable"
fi

# The equinox.io URL path 'bNyj1mQVY4c' is ngrok's stable channel identifier for v3.
# Supported values for NGROK_VERSION: 'stable', or specific versions like '3.5.0'.
DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-${NGROK_VERSION}-linux-${NGROK_ARCH}.tgz"

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi
        apt-get -y install --no-install-recommends "$@"
    fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages curl ca-certificates

echo "Downloading ngrok ${NGROK_VERSION} for ${NGROK_ARCH} from ${DOWNLOAD_URL}"

TEMP_DIR=$(mktemp -d)
if ! curl -sSL --fail "${DOWNLOAD_URL}" -o "${TEMP_DIR}/ngrok.tgz"; then
    echo "ERROR: Failed to download ngrok. Please verify the version '${NGROK_VERSION}' is valid and the URL is reachable: ${DOWNLOAD_URL}"
    rm -rf "${TEMP_DIR}"
    exit 1
fi
if ! tar -xzf "${TEMP_DIR}/ngrok.tgz" -C "${TEMP_DIR}"; then
    echo "ERROR: Failed to extract ngrok archive. The downloaded file may be corrupted."
    rm -rf "${TEMP_DIR}"
    exit 1
fi
install -m 0755 "${TEMP_DIR}/ngrok" /usr/local/bin/ngrok

rm -rf "${TEMP_DIR}"
rm -rf /var/lib/apt/lists/*

echo "ngrok installed successfully"
ngrok version
