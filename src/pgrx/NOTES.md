## Important Usage Notes for pgrx

pgrx stores its downloaded/compiled PostgreSQL instances and configuration in **`~/.pgrx`** (`PGRX_HOME`).

This directory **must be persistent** across container rebuilds/restarts — otherwise `cargo pgrx init` would need to run again every time, which is slow and unnecessary.

### Recommended Setup (strongly suggested)

Add the following to your project's `.devcontainer/devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/yskszk63/features/pgrx:latest": {}
    // or whatever your feature reference is
  },

  // ────────────────────────────────────────────────
  //  Critical: persist ~/.pgrx across container lifecycles
  // ────────────────────────────────────────────────
  "mounts": [
    "source=pgrx-home,target=/home/vscode/.pgrx,type=volume"
    // You can also use bind mount if you prefer host directory:
    // "source=${localEnv:HOME}/.pgrx,target=/home/vscode/.pgrx,type=bind"
  ],

  // Optional but very recommended: persist cargo registry/cache
  // (makes rebuilds much faster)
  "mounts": [
    "source=pgrx-home,target=/home/vscode/.pgrx,type=volume",
    "source=cargo-registry,target=/home/vscode/.cargo/registry,type=volume"
  ],

  // Usually not needed if your feature already installs cargo-pgrx as vscode user
  "remoteUser": "vscode",

  // You can run initialization automatically (recommended)
  "postCreateCommand": "cargo pgrx init --pg18 download   # or whichever version(s) you want",

  // Or if you want to support multiple versions (slower first start):
  // "postCreateCommand": "cargo pgrx init --pg16 download --pg17 download --pg18 download"
}
```

### Manual First-time Initialization

If you **did not** set `postCreateCommand`, do this once after the container starts:

```bash
# Only needed the very first time (or after you changed versions)
cargo pgrx init --pg18 download
```
