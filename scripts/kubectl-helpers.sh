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
OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
KREW="krew-${OS}_${ARCH}"
set -x
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
tar zxvf "${KREW}.tar.gz"
./"${KREW}" install krew
set +x

echo "Updating ~/.bashrc"
grep -q "export.*krew.*" ~/.bashrc || echo "export PATH=\$PATH:~/.krew/bin" >> ~/.bashrc
grep -q "alias k=kubectl" ~/.bashrc || echo "alias k=kubectl" >> ~/.bashrc
grep -q "complete -F __start_kubectl k" ~/.bashrc || echo "complete -F __start_kubectl k" >> ~/.bashrc
source ~/.bashrc

echo "Installing plugins"
kubectl krew install ctx
kubectl krew install ns
