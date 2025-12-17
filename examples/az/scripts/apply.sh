#!/usr/bin/env bash

export KUBECONFIG=$(pwd)/kubeconfig

# install agent sandbox
export VERSION="v0.1.0"

# To install only the core components:
kubectl apply -f https://github.com/kubernetes-sigs/agent-sandbox/releases/download/${VERSION}/manifest.yaml

# To install the extensions components:
kubectl apply -f https://github.com/kubernetes-sigs/agent-sandbox/releases/download/${VERSION}/extensions.yaml

pushd ../../vscode-sandbox
kubectl apply -k ./overlays/kata-mshv
popd

pushd ../../../clients/python/agentic-sandbox-client/sandbox-router
kube
ctl apply -f ./sandbox_router.yaml
popd