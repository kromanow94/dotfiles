#!/bin/bash
set -e 

DOTFILES_DIR=$(git rev-parse --show-toplevel)
OS_RELEASE=$(grep --no-filename ^NAME /etc/*-release | awk -F '[="]' '/^NAME=/ { print $3 }')

# install dependencies for running OS
if [ "${OS_RELEASE}" == "Arch Linux" ]; then
  sudo pacman -S --noconfirm python3-pip

elif [ "${OS_RELEASE}" == "Fedora" ]; then
  sudo dnf install -y python3-pip

elif [ "${OS_RELEASE}" == "CentOS Linux" ]; then
  sudo dnf install -y python3-pip

elif [ "${OS_RELEASE}" == "Ubuntu" ]; then
  sudo bash -c "apt-get update && apt-get install -y python3-pip"

elif [ "${OS_RELEASE}" == "Clear Linux OS" ]; then
  sudo swupd bundle-add tcl-basic network-basic python3-basic
fi

pip3 install --user ansible
