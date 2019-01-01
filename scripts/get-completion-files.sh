#!/bin/bash
set -e

echo "Downloading vagrant completion"
wget https://raw.githubusercontent.com/hashicorp/vagrant/master/contrib/bash/completion.sh  \
  -O bash-completion/bash_completion.d/vagrant.sh -o /dev/null
echo "Done"

echo "Downloading go completion"
wget https://raw.githubusercontent.com/skelterjohn/go-pkg-complete/master/go-pkg-complete.bash.inc \
  -O bash-completion/bash_completion.d/go -o /dev/null 
echo "Done"

echo "Downloading docker completion"
wget https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker \
  -O bash-completion/bash_completion.d/docker -o /dev/null 
echo "Done"

echo "Downloading tmux completion"
wget https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux \
  -O bash-completion/bash_completion.d/tmux -o /dev/null 
echo "Done"
