#!/bin/bash

read -p "Name of the deployment to cancel : " DEPLOYMENT

read -p "⚠️  Are you sure to undo the last deployment ? (y/N) " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "❌ Operation cancelled."
    exit 1
fi

echo "↩️  Rollback pending..."
kubectl rollout undo deployment/$DEPLOYMENT

echo "🔍 Status verification..."
kubectl rollout status deployment/$DEPLOYMENT
