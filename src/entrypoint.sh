#!/usr/bin/env bash

set -eo pipefail

declare -a rest_args

while [ $# -gt 0 ]; do
  case "$1" in
    --oc-enable-mssql=*) enable_mssql="${1#*=}" ;;
    --oc-mssql-server=*) mssql_server="${1#*=}" ;;
    --oc-mssql-database=*) mssql_database="${1#*=}" ;;
    --oc-mssql-user=*) mssql_user="${1#*=}" ;;
    --oc-mssql-password=*) mssql_password="${1#*=}" ;;
    *)
      rest_args+=("$1")
  esac
  shift
done

if [[ -d /var/run/secrets/kubernetes.io/serviceaccount ]]; then
  echo "[INFO] Found: /var/run/secrets/kubernetes.io/serviceaccount"
  /create-kubeconfig.sh
fi

if [[ $enable_mssql = true ]]; then
  /configure-mssql.sh --server="${mssql_server}" --database="${mssql_database}" --user="${mssql_user}" --password="${mssql_password}"
fi

# Run code-server

code-server --host 0.0.0.0 "${rest_args[@]}"
