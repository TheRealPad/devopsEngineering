#!/bin/bash

# Demander les paramètres
read -p "Name of the deployment : " DEPLOYMENT
read -p "Name of the conteneur : " CONTAINER
read -p "Name of the image (ex: monrepo/monimage) : " IMAGE
read -p "Tag of the image (ex: v1.2.3) : " TAG

# Appliquer la nouvelle image
echo "📦 Image update..."
kubectl set image deployment/$DEPLOYMENT $CONTAINER=$IMAGE:$TAG

# Surveiller le rollout
echo "🔄 Watch of the deployment..."
kubectl rollout status deployment/$DEPLOYMENT
