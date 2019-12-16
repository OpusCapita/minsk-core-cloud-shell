#!/usr/bin/env bash

set -xo pipefail

docker push $( ./get-docker-tag.sh )
