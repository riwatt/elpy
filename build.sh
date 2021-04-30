#!/bin/sh

set -e
set -u
set -o pipefail

docker build . -t elpy:testing
