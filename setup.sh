#!/bin/bash


if [[ -z "$1" ]]; then
  echo """Usage: $0 [install|setup|start|terminate]
  install: Install Operator Lifecycle Management, AWS Credentials, and ArgoCD Operator
  setup: Setup ArgoCD Applications
  start: start port-forwarding
  terminate: Terminate port-forwarding
  """
  exit 1
fi

if [[ "install" == "$1" ]]; then
  # Install Operator Lifecycle Management
  curl -L https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.27.0/install.sh -o install.sh && chmod +x install.sh && ./install.sh v0.27.0
  # AWS Credentials
  kubectl create secret generic aws-secret -n crossplane-system --from-file .cred/aws-aws-credentials
  # Install ArgoCD Operator
  helm install -n gitops-system argocd argo/argo-cd --version 6.7.3 --wait
  kubectl apply -f .creds/repo.yaml

  exit 0
fi

if [[ "start" == "$1" ]]; then
  # Start ArgoCD
  echo "starting port-forwarding for ArgoCD"
  echo "ARGOCD: https://localhost:8443"
  echo "ArgoCD pass: $(kubectl get secret -n gitops-system argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)"
  kubectl port-forward -n gitops-system svc/argocd-server 8443:443 > /dev/null &
  ARGO_PID=$!
  echo $ARGO_PID > PIDS

  exit 0
fi

if [[ "setup" == "$1" ]]; then
  # Setup ArgoCD
  echo "Creating ArgoCD Applications"

  # TODO

  exit 0
fi


if [[ "terminate" == "$1" ]]; then
  # Terminate ArgoCD
  kill -9 $(cat PIDS)
  rm PIDS

  exit 0
fi


