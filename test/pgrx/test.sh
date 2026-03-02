#!/bin/bash

set -e

source dev-container-features-test-lib

check "cargo exists" cargo --version
check "cargo-pgrx exists" cargo pgrx --version

reportResults
