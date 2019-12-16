#!/usr/bin/env bash

set -eo pipefail

echo "[INFO] Create ~/.kube/config with current cluster and namespace context ServiceAccount credentials"

bearer_token="$( cat /var/run/secrets/kubernetes.io/serviceaccount/token )"
crt_path="/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
kube_api_url="kubernetes.default.svc"
kube_cluster_name="kubernetes"
kube_context_name="kubernetes"
kube_user_name="webshell"
kube_namespace="$( cat /var/run/secrets/kubernetes.io/serviceaccount/namespace )"

kubectl config \
  set-cluster \
  "${kube_cluster_name}" \
  --server="${kube_api_url}" \
  --certificate-authority="${crt_path}" \
  --embed-certs=true

kubectl config \
    set-credentials "${kube_user_name}" --token="${bearer_token}"

kubectl config \
  set-context "${kube_context_name}" \
  --cluster="${kube_api_url}" \
  --namespace="${kube_namespace}" \
  --user="${kube_user_name}"

kubectl config \
  use-context "${kube_context_name}"
