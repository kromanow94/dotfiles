#!/bin/bash
set -e 

DOTFILES_DIR=$(git rev-parse --show-toplevel)
OS_RELEASE=$(grep --no-filename ^NAME /etc/*-release | awk -F '[="]' '/^NAME=/ { print $3 }')

# install dependencies for running OS
if [ "${OS_RELEASE}" == "Arch Linux" ]; then
  sudo pacman -S --noconfirm python python2 python-pip ansible

elif [ "${OS_RELEASE}" == "Fedora" ]; then
  sudo dnf install -y python python2 python-pip ansible

elif [ "${OS_RELEASE}" == "CentOS Linux" ]; then
  sudo dnf install -y python python2 python-pip ansible
fi

