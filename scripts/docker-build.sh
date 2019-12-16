#!/usr/bin/env bash

set -xo pipefail

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker build --pull -t $( $script_dir/get-docker-tag.sh ) .
