#!/usr/bin/env bash

set -eo pipefail

if [[ -d /var/run/secrets/kubernetes.io/serviceaccount ]]; then
  echo "[INFO] Found: /var/run/secrets/kubernetes.io/serviceaccount"
  /create-kubeconfig.sh
fi

# Run code-server
code-server --host 0.0.0.0 $@
