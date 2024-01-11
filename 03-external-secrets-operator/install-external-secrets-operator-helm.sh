#!/bin/bash

# Add repo for external secrets operator
helm repo add external-secrets https://charts.external-secrets.io

# Update your local Helm chart repository cache
helm repo update external-secrets

# Install external secrets operator into its own new namespace
helm install external-secrets \
   external-secrets/external-secrets \
    -n external-secrets \
    --create-namespace \
    --set installCRDs=true
