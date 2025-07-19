#!/bin/bash
set -e

if ! (which rustup > /dev/null && which cargo > /dev/null); then
    which curl > /dev/null || (apt update && apt install curl -y -qq)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
fi

dpkg -l | grep build-essential || (apt update && apt install build-essential -y -qq)

if ! cargo install --list | grep "cargo-binstall" > /dev/null; then
    if [ -z "${BINSTALL_VERSION}" ] || [ "${BINSTALL_VERSION}" = "latest" ]; then
        cargo install cargo-binstall
    else
        cargo install cargo-binstall --version ${BINSTALL_VERSION}
    fi
fi

umask 002
if [ -z "${VERSION}" ] || [ "${VERSION}" = "latest" ]; then
	cargo binstall cargo-lambda --locked -y > /dev/null
else
    cargo binstall cargo-lambda --locked -y --version $VERSION > /dev/null
fi
