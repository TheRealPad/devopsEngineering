#!/bin/bash

echo "--- Deleting existing Kubernetes resources ---"

echo "Deleting Ingresses..."
kubectl delete -f poll-ingress.yaml --ignore-not-found=true
kubectl delete -f result-ingress.yaml --ignore-not-found=true

echo "Deleting Deployments and StatefulSets..."
kubectl delete -f poll-deployment.yaml --ignore-not-found=true
kubectl delete -f redis-deployment.yaml --ignore-not-found=true
kubectl delete -f worker-deployment.yaml --ignore-not-found=true
kubectl delete -f db-statefulset.yaml --ignore-not-found=true
kubectl delete -f result-deployment.yaml --ignore-not-found=true

echo "Waiting for pods to terminate..."
sleep 5

echo "Deleting Services..."
kubectl delete -f redis-service.yaml --ignore-not-found=true
kubectl delete -f db-service.yaml --ignore-not-found=true

echo "Deleting PersistentVolumeClaims..."
kubectl delete -f db-persistentvolumeclaim.yaml --ignore-not-found=true

echo "Deleting ConfigMaps and Secrets..."
kubectl delete -f db-credentials-secret.yaml --ignore-not-found=true
kubectl delete -f db-init-script-configmap.yaml --ignore-not-found=true

echo "--- All specified resources deleted. ---"
