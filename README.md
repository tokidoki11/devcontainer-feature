# Dev Container Features: Cargo Lambda

> This repository contains a feature of devcontainer to install [cargo-lambda](https://www.cargo-lambda.info/)


# How to use

Running `hello` inside the built container will print the greeting provided to it via its `greeting` option.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/devcontainers/tokidoki/cargo-lambda": {
            "version": ""  // default to blank(latest), specify semver
        }
    }
}
```
