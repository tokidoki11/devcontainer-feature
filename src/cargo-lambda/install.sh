#!/bin/bash
set -e

if [ -z "${VERSION}" ] || [ "${VERSION}" = "latest" ]; then
	cargo binstall cargo-lambda --locked -y > /dev/null
else
    cargo binstall cargo-lambda --locked -y --version $VERSION > /dev/null
fi
