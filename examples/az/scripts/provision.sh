#!/usr/bin/env bash

az group create --name myResourceGroup --location southcentralus

az aks create \
    --name testKata \
    --resource-group myResourceGroup \
    --os-sku AzureLinux \
    --workload-runtime KataVmIsolation \
    --node-vm-size Standard_D4s_v3 \
    --node-count 3 \
    --generate-ssh-keys

# get kubeconfig
az aks get-credentials --resource-group myResourceGroup --name testKata -a -f ./kubeconfig
export KUBECONFIG=./kubeconfig

# install agent sandbox
export VERSION="v0.1.0"

# To install only the core components:
kubectl apply -f https://github.com/kubernetes-sigs/agent-sandbox/releases/download/${VERSION}/manifest.yaml

# To install the extensions components:
kubectl apply -f https://github.com/kubernetes-sigs/agent-sandbox/releases/download/${VERSION}/extensions.yaml

pushd ../../vscode-sandbox
kubectl apply -k ./overlays/kata
popd