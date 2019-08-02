#!/usr/bin/env bash

# AWS ACM: arn:aws:acm:xxxxxxxxxxx
export ACM="arn:aws:acm:xxxxxxxxxxx"
# domain name for your docker registry without schema (http/https): your.go-pg-app.com
export DOMAIN="your.go-pg-app.com"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
envsubst < ./ingress-nginx/service-nlb.yaml.tmpl > /tmp/service-nlb.yaml
kubectl apply -f /tmp/service-nlb.yaml

kubectl apply -f ./common/namespace.yaml
kubectl apply -f ./common/configmap.yaml
kubectl apply -f ./common/secrets.yaml

kubectl create configmap prometheus -n go-pg-app --from-file ./prometheus/prometheus.yaml
kubectl apply -f ./prometheus/deployment.yaml
kubectl apply -f ./prometheus/service.yaml

kubectl apply -f ./pg/deployment.yaml
kubectl apply -f ./pg/service.yaml

kubectl apply -f ./java/deployment.yaml
kubectl apply -f ./java/service.yaml

kubectl apply -f ./go/deployment.yaml
kubectl apply -f ./go/service.yaml
envsubst < ./go/ingress.yaml.tmpl > /tmp/ingress.yaml
kubectl apply -f /tmp/ingress.yaml
