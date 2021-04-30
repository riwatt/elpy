#!/bin/sh

docker run --rm -it -v "$(pwd)":/src elpy:testing bash
