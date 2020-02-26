#!/usr/bin/env bash

set -eo pipefail

settings_file="${HOME}/.vscode/settings.json"

echo "[INFO] Write MSSQL connection data to ${settings_file}"

while [ $# -gt 0 ]; do
  case "$1" in
    --server=*) server="${1#*=}" ;;
    --database=*) database="${1#*=}" ;;
    --user=*) user="${1#*=}" ;;
    --password=*) password="${1#*=}" ;;
    *)
      echo "$(basename $0) ERROR: invalid argument ${1}"
      exit 1
  esac
  shift
done

for v in server database user password; do
  if [[ -z "${!v}" ]]; then
    printf "$(basename $0): ERROR: $v is required but empty\n"
    exit 1
  fi
done

tmp=$(mktemp)

if test -f ${settings_file}; then
  cat ${settings_file} > $tmp
else
  echo '{}' > $tmp
fi

mkdir -p $(dirname ${settings_file})

cat $tmp | jq \
  --arg server "${server}" \
  --arg database "${database}" \
  --arg user "${user}" \
  --arg password "${password}" '.["mssql.connections"]=[
    {
      "authenticationType": "SqlLogin",
      "server": $server,
      "database": $database,
      "user": $user,
      "password": $password,
      "savePassword": true
    }
  ]' > ${settings_file}
