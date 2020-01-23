#!/bin/bash
set -e

echo "Downloading vagrant completion"
wget https://raw.githubusercontent.com/hashicorp/vagrant/master/contrib/bash/completion.sh  \
    -O bash-completion/bash_completion.d/vagrant.sh -o /dev/null
echo "Done"

echo "Downloading go completion"
go get -u github.com/posener/complete/gocomplete || echo "Golang not installed, go completion not installed"
gocomplete -install || echo "Golang not installed or not in PATH"
echo "Done"

echo "Downloading docker completion"
wget https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker \
    -O bash-completion/bash_completion.d/docker -o /dev/null
echo "Done"

echo "Downloading tmux completion"
wget https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux \
    -O bash-completion/bash_completion.d/tmux -o /dev/null
echo "Done"

echo "Download kubectx completion"
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.bash \
    -O bash-completion/bash_completion.d/kubectx -o /dev/null
sed "s:^complete -F _kube_contexts.*:& kubectl-ctx:g" -i bash-completion/bash_completion.d/kubectx
grep -q kctx ~/.bashrc || echo alias kctx='kubectl-ctx' >> ~/.bashrc
echo "Done"

echo "Download kubens completion"
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubens.bash \
    -O bash-completion/bash_completion.d/kubens -o /dev/null
sed "s:^complete -F _kube_namespaces.*:& kubectl-ns:g" -i bash-completion/bash_completion.d/kubens
grep -q kns ~/.bashrc || echo alias kns='kubectl-ns' >> ~/.bashrc
echo "Done"
