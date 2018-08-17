#!/bin/bash
set -e 

DOTFILES_DIR=$(git rev-parse --show-toplevel)
OS_RELEASE=$(grep --no-filename ^NAME /etc/*-release | awk -F '[="]' '/^NAME=/ { print $3 }')

# install dependencies for running OS
if [ "${OS_RELEASE}" == "Arch Linux" ]; then
  sudo pacman -S --noconfirm python-pip ansible libvirt qemu vagrant gcc make bridge-utils dmidecode dnsmasq ebtables pkg-config
  sudo systemctl enable libvirtd.service
  sudo systemctl start libvirtd.service
  vagrant plugin install pkg-config

  # workaround from https://wiki.archlinux.org/index.php/Vagrant#vagrant-libvirt
  CONFIGURE_ARGS='with-ldflags=-L/opt/vagrant/embedded/lib with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib' \
  GEM_HOME=~/.vagrant.d/gems GEM_PATH=$GEM_HOME:/opt/vagrant/embedded/gems PATH=/opt/vagrant/embedded/bin:$PATH \
  vagrant plugin install vagrant-libvirt

elif [ "${OS_RELEASE}" == "Fedora" ]; then
  sudo dnf install -y python-pip python2-dnf ansible

elif [ "${OS_RELEASE}" == "CentOS Linux" ]; then
  sudo dnf install -y python-pip python2-dnf ansible
fi

ansible-playbook ./playbooks/install-tmux.yml -v

# create virtualenv so installation won't affect system configuration
pip install --user virtualenv
~/.local/bin/virtualenv dotenv

cd dotenv
. bin/activate
# tmux installation was moved out of virtualenv.
# Leaving it for possible future installs.
deactivate
cd -

