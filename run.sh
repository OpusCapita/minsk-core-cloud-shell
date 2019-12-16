#!/usr/bin/env bash

set -e

script_dir="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"
project_root_dir=$( cd "$script_dir" && git rev-parse --show-toplevel )

ci_docker_image="vault:1.3.0"

echo "[INFO] Start preconfigured Docker container"

docker run \
  --rm \
  -it \
  --workdir=/application \
  -e VAULT_ADDR="$VAULT_ADDR" \
  -e VAULT_TOKEN="$VAULT_TOKEN" \
  -v "$project_root_dir":/application:delegated \
  -v /var/run/docker.sock:/var/run/docker.sock \
  "$ci_docker_image" sh -c "./src/scripts/install-dependencies.sh; $*"
