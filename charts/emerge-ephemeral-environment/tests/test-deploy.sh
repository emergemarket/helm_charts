#!/bin/bash

rm -rf ../Chart.lock
rm -rf ../helm/*
helm dependency build ../
./template.sh -f ../values.yaml --set fullnameOverride=example --set globalEnv.env=devopstest . --output-dir helm
kubectl apply -f ../helm/helm-template/templates/namespace.yaml --dry-run=server
kubectl apply -R -f ../helm/helm-template/charts*  --dry-run=server

