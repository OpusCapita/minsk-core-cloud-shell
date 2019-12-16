#!/usr/bin/env bash

set -xo pipefail

docker build --pull -t $( ./get-docker-tag.sh ) .
