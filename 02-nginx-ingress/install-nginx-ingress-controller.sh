#!/bin/bash

# Add the nginx helm repo
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Update your local Helm chart repository cache
helm repo update ingress-nginx

# Install the nginx helm
helm install \
  quickstart ingress-nginx/ingress-nginx --namespace akeyless --create-namespace

# Wait for the IP to be assigned to the load balancer
while [ -z "$(kubectl get services quickstart-ingress-nginx-controller -n akeyless -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" ]; do
  echo "Waiting 5 seconds for IP check..."
  sleep 5
done

# Once the IP is available, display it
kubectl get services quickstart-ingress-nginx-controller -n akeyless -o jsonpath='{.status.loadBalancer.ingress[0].ip}' && echo

echo "The above IP address is the external IP for the NGINX Ingress Controller Load Balancer. You can now set up your DNS to point to this IP."
