#!/bin/bash

rm -rf ../Chart.lock
rm -rf ../helm/*
helm dependency build ../
./template.sh --debug -f ../values.yaml -f testvals.yaml --set fullnameOverride=example --set globalEnv.env=devopstest ../ --output-dir ../helm
kubectl apply -f ../helm/environment-template/templates/namespace.yaml #--dry-run=server
kubectl apply -R -f ../helm/environment-template*  #--dry-run=server

