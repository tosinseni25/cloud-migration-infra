#!/bin/bash

set -e

NAMESPACE="monitoring"
RELEASE_NAME="monitoring"
CHART="prometheus-community/kube-prometheus-stack"
VALUES_FILE="monitoring/prometheus-values.yaml"

echo "Adding Prometheus community Helm repo..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "Creating namespace: $NAMESPACE"
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply --validate=false -f -
echo "Installing kube-prometheus-stack..."
helm upgrade --install $RELEASE_NAME $CHART \
  --namespace $NAMESPACE \
  --values $VALUES_FILE \
  --wait \
  --timeout 10m

echo "Prometheus stack deployed successfully!"
echo ""
echo "Access Prometheus:"
kubectl get svc -n $NAMESPACE | grep LoadBalancer