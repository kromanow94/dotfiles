#!/bin/bash
set -e

if ! command -v kubectl ; then
    echo Installing kubectl to ~/.local/bin/
    TMPDIR=$(mktemp -d)
    cd "${TMPDIR}"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mv kubectl ~/.local/bin/
    cd -
    rm -rf "${TMPDIR}"
fi

echo "Downloading krew archive"
TMPDIR=$(mktemp -d)
cd "${TMPDIR}"
OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
KREW="krew-${OS}_${ARCH}"
set -x
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
tar zxvf "${KREW}.tar.gz"
./"${KREW}" install krew
set +x
cd -
rm -rf "${TMPDIR}"

echo "Configuring kubectl completion"
kubectl completion bash > bash-completion/bash_completion.d/kubectl

echo "Updating ~/.bashrc"
ln -s ~/.local/bin/kubectl ~/.local/bin/k
grep -q "export.*krew.*" ~/.bashrc || echo "export PATH=\$PATH:~/.krew/bin" >> ~/.bashrc
grep -q "complete -F __start_kubectl k" ~/.bashrc || echo "complete -F __start_kubectl k" >> ~/.bashrc
source ~/.bashrc

echo "Installing plugins"
kubectl krew install ctx
kubectl krew install ns
kubectl krew install view-serviceaccount-kubeconfig
