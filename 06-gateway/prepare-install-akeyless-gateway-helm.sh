#!/bin/bash

# Add Akeyless Helm repo
helm repo add akeyless https://akeylesslabs.github.io/helm-charts

# Update Helm akeyless repo
helm repo update akeyless

# Download latest values for Akeyless API Gateway
helm show values akeyless/akeyless-api-gateway > values.yaml


echo "We create a new Akeyless GCP Auth Method of type IAM for the gateway to use to log into the SaaS"

# Add GCP IAM auth method
akeyless create-auth-method-gcp -n "GCP IAM" --type "iam" --bound-projects "customer-success-391112"

# Notify that the values file can now be updated for gateway deployment
echo "The values file can now be updated for gateway deployment."
