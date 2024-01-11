#!/bin/bash

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update jetstack

# Install the cert-manager Helm chart
helm install \
  cert-manager jetstack/cert-manager \
  --namespace akeyless \
  --create-namespace \
  --version v1.13.3 \
  --set installCRDs=true
