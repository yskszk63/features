# Dev Container Features Collection

A personal collection of Dev Container Features.

Published on GHCR: `ghcr.io/yskszk63/features/<feature-id>[:version|latest]`

## Currently Available Features

| Feature ID | Description                                                                 | Version | Status    |
|------------|-----------------------------------------------------------------------------|---------|-----------|
| pgrx       | Installs [pgrx](https://github.com/pgcentralfoundation/pgrx) — Build Postgres Extensions with Rust! | 0.1.x   | Stable    |

See each feature's own `README.md` inside `src/<feature>/` for all supported options.

## Developing / Testing Locally

Prerequisites: [devcontainer CLI](https://github.com/devcontainers/cli)

```bash
# Clone & enter
git clone https://github.com/yskszk63/features.git
cd features

# Test a single feature (example: pgrx)
devcontainer features test -f pgrx
```

## License

[MIT](./LICENSE)
