#!/bin/bash
set -e

if ! command -v kubectl ; then
    echo Installing kubectl to ~/.local/bin/
    cd $(mktemp -d)
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mv kubectl ~/.local/bin/
fi

echo "Downloading krew archive"
cd "$(mktemp -d)"
curl -LO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.{tar.gz,yaml}"
tar zxvf krew.tar.gz
KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64"
"$KREW" install --manifest=krew.yaml --archive=krew.tar.gz
"$KREW" update

echo "Updating ~/.bashrc"
grep -q "export.*krew.*" ~/.bashrc || echo "export PATH=\$PATH:~/.krew/bin" >> ~/.bashrc
grep -q "alias k=kubectl" ~/.bashrc || echo "alias k=kubectl" >> ~/.bashrc
grep -q "complete -F __start_kubectl k" ~/.bashrc || echo "complete -F __start_kubectl k" >> ~/.bashrc
source ~/.bashrc

echo "Installing plugins"
kubectl krew install ctx
kubectl krew install ns
