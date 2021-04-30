#!/bin/bash

set -e
set -u
set -o pipefail

time docker build . -t elpy:testing
time docker run --rm -it elpy:testing bash -c 'emacs --version ; python --version ; cask --version ; cask install ; PYTHONPATH="`pwd`" cask exec ert-runner --reporter ert+duration'
