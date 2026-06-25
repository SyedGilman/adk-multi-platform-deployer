#!/bin/bash
set -e
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
