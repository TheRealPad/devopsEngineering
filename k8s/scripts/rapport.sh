#!/bin/bash

# Date du jour
DATE=$(date +'%Y-%m-%d')

# Fichier de rapport
REPORT_FILE="./report_$DATE.txt"

echo "===== Rapport du cluster Kubernetes =====" > "$REPORT_FILE"
echo "Date : $DATE" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Infos sur les pods
kubectl get pods -A >> "$REPORT_FILE"

# Infos sur les déploiements
echo "" >> "$REPORT_FILE"
kubectl get deployments -A >> "$REPORT_FILE"

# Infos sur les services
echo "" >> "$REPORT_FILE"
kubectl get services -A >> "$REPORT_FILE"

# Envoi par email (exemple avec mailx)
mail -s "Rapport Kubernetes $DATE" delgadopierrealexandre@gmail.com < "$REPORT_FILE"