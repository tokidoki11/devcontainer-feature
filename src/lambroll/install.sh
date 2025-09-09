#!/bin/bash
set -e

# Get version from options
VERSION=${VERSION:-"latest"}

# Detect architecture
ARCH=$(dpkg --print-architecture)
case $ARCH in
    amd64) LAMBROLL_ARCH="linux_amd64" ;;
    arm64) LAMBROLL_ARCH="linux_arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

which wget > /dev/null || (apt update && apt install wget -y -qq)

# If version is "latest", fetch the latest version tag from GitHub
if [ "$VERSION" = "latest" ]; then
    wget -q https://api.github.com/repos/fujiwara/lambroll/releases -O releases.json
    VERSION=$(grep -oP '"tag_name": "\K(.*)(?=")' releases.json | head -n 1)
    if [ -z "$VERSION" ]; then
        echo "Failed to fetch the latest version"
        exit 1
    fi
fi


# Download pre-built binary
DOWNLOAD_URL="https://github.com/fujiwara/lambroll/releases/download/${VERSION}/lambroll_${VERSION}_${LAMBROLL_ARCH}.tar.gz"
echo "Downloading lambroll from: $DOWNLOAD_URL"
wget -q "$DOWNLOAD_URL" -O lambroll.tar.gz

# Extract binary
tar xf lambroll.tar.gz

# Install binary
chmod +x lambroll
mv lambroll /usr/local/bin/lambroll

# Cleanup
rm -rf "$TEMP_DIR"

echo "lambroll ${VERSION} installed successfully"