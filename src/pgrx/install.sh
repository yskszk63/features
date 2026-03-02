#!/bin/bash
set -e

VERSION=${VERSION:-latest}

# Setup STDERR.
err() {
    echo "(!) $*" >&2
}

if [ "$(id -u)" -ne 0 ]; then
    err 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [[ "$VERSION" != latest ]]; then
    PGRX_VERSION="@$VERSION"
fi

install_using_apt() {
    export DEBIAN_FRONTEND=noninteractive

    apt-get update -y
    apt-get -y install --no-install-recommends build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc ccache pkg-config libicu-dev
    rm -rf /var/lib/apt/lists/*
}

install_using_apt

cargo install --locked "cargo-pgrx$PGRX_VERSION"

echo "Done!"
