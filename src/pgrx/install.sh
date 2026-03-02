#!/bin/bash
set -e

VERSION=${VERSION:-latest}
# REF https://github.com/devcontainers/features/blob/d79c223de2849c671c806c1a86ca9302993bac8c/src/rust/install.sh#L17
USERNAME="${USERNAME:-"${_REMOTE_USER:-"automatic"}"}"

# Setup STDERR.
err() {
    echo "(!) $*" >&2
}

if [ "$(id -u)" -ne 0 ]; then
    err 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# REF https://github.com/devcontainers/features/blob/d79c223de2849c671c806c1a86ca9302993bac8c/src/rust/install.sh#L17
# Determine the appropriate non-root user
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
        if id -u "${CURRENT_USER}" > /dev/null 2>&1; then
            USERNAME=${CURRENT_USER}
            break
        fi
    done
    if [ "${USERNAME}" = "" ]; then
        USERNAME=root
    fi
elif [ "${USERNAME}" = "none" ] || ! id -u "${USERNAME}" > /dev/null 2>&1; then
    USERNAME=root
fi
if [[ "$VERSION" != latest ]]; then
    PGRX_VERSION="@$VERSION"
fi

install_using_apt() {
    export DEBIAN_FRONTEND=noninteractive

    apt-get update -y
    apt-get -y install --no-install-recommends libclang-dev build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc ccache pkg-config libicu-dev
    rm -rf /var/lib/apt/lists/*
}

install_using_apt

su - $USERNAME -c "env CARGO_HOME=$CARGO_HOME RUSTUP_HOME=$RUSTUP_HOME $CARGO_HOME/bin/cargo install --locked cargo-pgrx$PGRX_VERSION"

echo "Done!"
