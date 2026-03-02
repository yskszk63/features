#!/bin/bash

set -e

source dev-container-features-test-lib

check 'cargo exists' cargo --version
check 'cargo-pgrx exists' cargo pgrx --version
check 'check version' bash -c 'cargo pgrx --version|grep 0.16.1'

reportResults
