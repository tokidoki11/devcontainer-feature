# Dev Container Features

> This repository contains features of devcontainer to install of following
> 
> - [cargo-lambda](https://www.cargo-lambda.info/)
> - [lambroll](https://github.com/fujiwara/lambroll)
> - [ngrok](https://ngrok.com/)


# How to use

cargo-lambda: [Readme](src/cargo-lambda/README.md)
note:
  - This will install zig to latest version via (ghcr.io/devcontainers-extra/features/zig:1)
  - `rust` and `binstall` when not available, will be downloaded  

Lambroll: [Readme](src/lambroll/README.md)

ngrok: [Readme](src/ngrok/README.md)

- Supports `amd64` (x86_64) and `arm64` (aarch64) architectures
- Defaults to the latest stable release; a specific version can be pinned via the `version` option