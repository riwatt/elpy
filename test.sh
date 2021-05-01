#!/bin/sh

set -e
set -u
set -o pipefail

docker run --rm -it elpy:testing bash -c 'emacs --version ; python --version ; cask --version ; cask install ; PYTHONPATH="`pwd`" cask exec ert-runner --reporter ert+duration test/elpy-company--cache-name-test.el test/elpy-company-backend-test.el'
