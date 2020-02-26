#!/usr/bin/env bash

set -eo pipefail

echo "opuscapita/minsk-core-cloud-shell:$( git rev-parse --abbrev-ref HEAD )"
