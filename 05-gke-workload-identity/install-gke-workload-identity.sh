#!/bin/bash

# Create akeyless namespace
kubectl create namespace akeyless

# Create gw-sandbox Kubernetes service account
kubectl create serviceaccount gw-sandbox -n akeyless

# Annotate service account
kubectl annotate serviceaccount gw-sandbox \
    --namespace akeyless iam.gke.io/gcp-service-account=gw-sandbox@customer-success-391112.iam.gserviceaccount.com

# Create gcp service account to tie to workload identity
gcloud iam service-accounts create gw-sandbox \
    --project=customer-success-391112

# Check if the gcp service account for gw workload identity already exists
if ! gcloud iam service-accounts describe gw-sandbox@customer-success-391112.iam.gserviceaccount.com --project=customer-success-391112 &> /dev/null; then
    # Create gcp service account for gw workload identity if it does not exist
    gcloud iam service-accounts create gw-sandbox \
        --project=customer-success-391112
fi

# Create gcp iam policy binding to allow workload identity
gcloud iam service-accounts add-iam-policy-binding gw-sandbox@customer-success-391112.iam.gserviceaccount.com \
    --role roles/iam.workloadIdentityUser \
    --member "serviceAccount:customer-success-391112.svc.id.goog[akeyless/gw-sandbox]"

