#!/bin/bash

current_directory=$(pwd)


if [ ! -f "${current_directory}/values.yaml" ]; then
    echo "Unable to find values file for gateway so creating a new one"
    ./prepare-install-akeyless-gateway-helm.sh
    echo -e "\n\nRun this script again after updating the values file to have the proper deployment"
    exit 0
else
    echo "Creating the Cert-Manager Issuer"
    kubectl create -f "${current_directory}"/issuer.yaml
    echo "Installing the akeyless sandbox gateway helm chart"
    helm install gw-sbx akeyless/akeyless-api-gateway -n akeyless -f values.yaml
    echo "Installing Cluster Role Binding for Kubernetes Auth"
    kubectl create -f "${current_directory}"/cluster-role-binding.yaml
fi
