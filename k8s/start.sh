#!/bin/bash

echo "--- Starting new deployment ---"

echo "Applying ConfigMaps and Secrets..."
kubectl apply -f db-credentials-secret.yaml
kubectl apply -f db-init-script-configmap.yaml

echo "Applying PersistentVolumeClaims..."
kubectl apply -f db-persistentvolumeclaim.yaml

echo "Applying Services..."
kubectl apply -f poll-service.yaml
kubectl apply -f redis-service.yaml
kubectl apply -f db-service.yaml
kubectl apply -f result-service.yaml

echo "Applying Deployments and StatefulSets..."
kubectl apply -f poll-deployment.yaml
kubectl apply -f redis-deployment.yaml
kubectl apply -f worker-deployment.yaml
kubectl apply -f db-statefulset.yaml
kubectl apply -f result-deployment.yaml

echo "Applying Ingresses..."
kubectl apply -f poll-ingress.yaml
kubectl apply -f result-ingress.yaml

echo "--- Deployment process complete. ---"
echo "Checking status of deployments, pods, and services..."
kubectl get deployments
kubectl get pods
kubectl get services

# --- Port-forwarding section ---

echo ""
echo "--- Setting up Port-Forwarding ---"

read -p "Enter the local port for Poll service (e.g., 5050): " POLL_PORT_LOCAL
while [[ -z "$POLL_PORT_LOCAL" || ! "$POLL_PORT_LOCAL" =~ ^[0-9]+$ ]]; do
  echo "Invalid input. Please enter a valid port number."
  read -p "Enter the local port for Poll service (e.g., 5050): " POLL_PORT_LOCAL
done

read -p "Enter the local port for Result service (e.g., 5001): " RESULT_PORT_LOCAL
while [[ -z "$RESULT_PORT_LOCAL" || ! "$RESULT_PORT_LOCAL" =~ ^[0-9]+$ ]]; do
  echo "Invalid input. Please enter a valid port number."
  read -p "Enter the local port for Result service (e.g., 5001): " RESULT_PORT_LOCAL
done

echo ""
echo "Starting port-forwarding. These commands will block the terminal."
echo "You will need to open new terminal windows to access your services."
echo ""
echo "For Poll app: http://localhost:$POLL_PORT_LOCAL"
echo "For Result app: http://localhost:$RESULT_PORT_LOCAL"
echo ""

echo "Running: kubectl port-forward service/poll-service $POLL_PORT_LOCAL:80"
kubectl port-forward service/poll-service "$POLL_PORT_LOCAL":80 >/dev/null 2>&1 &
POLL_PF_PID=$!

echo "Running: kubectl port-forward service/result-service $RESULT_PORT_LOCAL:80"
kubectl port-forward service/result-service "$RESULT_PORT_LOCAL":80 >/dev/null 2>&1 &
RESULT_PF_PID=$!

echo "Port-forwarding commands initiated in the background."
echo "PIDs: Poll=$POLL_PF_PID, Result=$RESULT_PF_PID"
echo "To stop port-forwarding, run: kill $POLL_PF_PID $RESULT_PF_PID"
echo ""
echo "Press Ctrl+C to stop this script and the background port-forwarding processes."

wait $POLL_PF_PID $RESULT_PF_PID

trap "echo -e '\nStopping port-forwarding...'; kill $POLL_PF_PID $RESULT_PF_PID 2>/dev/null; exit" INT TERM EXIT

while true; do
  sleep 60
done