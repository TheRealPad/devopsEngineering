#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <dev|test|prod>"
  exit 1
fi

ENV="$1"

if [[ "$ENV" != "dev" && "$ENV" != "test" && "$ENV" != "prod" ]]; then
  echo "Error: environment must be one of: dev, test, prod"
  exit 1
fi

echo "--- Deleting existing Kubernetes resources ---"

echo "Deleting Ingresses..."
kubectl delete -f ../poll-ingress.yaml --ignore-not-found=true
kubectl delete -f ../result-ingress.yaml --ignore-not-found=true

echo "Deleting Deployments and StatefulSets..."
kubectl delete -f ../poll-deployment.yaml --ignore-not-found=true
kubectl delete -f ../redis-deployment.yaml --ignore-not-found=true
kubectl delete -f ../worker-deployment.yaml --ignore-not-found=true
kubectl delete -f ../db-statefulset.yaml --ignore-not-found=true
kubectl delete -f ../result-deployment.yaml --ignore-not-found=true

echo "Waiting for pods to terminate..."
sleep 5

echo "Deleting Services..."
kubectl delete -f ../redis-service.yaml --ignore-not-found=true
kubectl delete -f ../db-service.yaml --ignore-not-found=true

echo "Deleting PersistentVolumeClaims..."
kubectl delete -f ../db-persistentvolumeclaim.yaml --ignore-not-found=true

echo "Deleting ConfigMaps and Secrets..."
kubectl delete -f ../config/db-credentials-sealed-$ENV.yaml --ignore-not-found=true
kubectl delete -f ../config/deployment-configmap-$ENV.yaml --ignore-not-found=true
kubectl delete -f ../config/db-init-script-configmap-$ENV.yaml --ignore-not-found=true

echo "Deleting Horizontal Pod Autoscalers (HPA)..."
kubectl delete -f ../poll-hpa.yaml --ignore-not-found=true
kubectl delete -f ../worker-hpa.yaml --ignore-not-found=true
kubectl delete -f ../result-hpa.yaml --ignore-not-found=true

echo "Deleted cron jobs..."
kubectl delete -f ../cron/cron-report-generation.yaml --ignore-not-found=true

echo "--- All specified resources deleted. ---"
