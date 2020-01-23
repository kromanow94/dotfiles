#!/bin/bash
set -e

echo "Downloading krew archive"
cd "$(mktemp -d)"
curl -LO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.{tar.gz,yaml}"
tar zxvf krew.tar.gz
KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64"
"$KREW" install --manifest=krew.yaml --archive=krew.tar.gz
"$KREW" update

echo "Updating ~/.bashrc"
grep -q "export.*krew.*" ~/.bashrc || echo "export PATH=\$PATH:~/.krew/bin" >> ~/.bashrc
source ~/.bashrc

echo "Installing plugins"
kubectl krew install ctx
kubectl krew install ns
