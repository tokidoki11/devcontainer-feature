# ngrok

Installs [ngrok](https://ngrok.com/), a secure tunnel to localhost. Supports both `amd64` and `arm64` architectures.

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Version of ngrok to install (e.g. `latest`, `stable`, or a specific version like `3.5.0`) | string | latest |

## Usage

Add to your `devcontainer.json`:

```jsonc
{
    "features": {
        "ghcr.io/tokidoki11/devcontainer-feature/ngrok:1": {}
    }
}
```

To install a specific version:

```jsonc
{
    "features": {
        "ghcr.io/tokidoki11/devcontainer-feature/ngrok:1": {
            "version": "3.5.0"
        }
    }
}
```
