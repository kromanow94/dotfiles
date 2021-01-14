#!/bin/bash
set -e

OS_RELEASE=$(grep --no-filename ^NAME /etc/*-release | awk -F '[="]' '/^NAME=/ { print $2 }')

# install dependencies for running OS
if [ "${OS_RELEASE}" == "Fedora" ] || [ "${OS_RELEASE}" == "CentOS Linux" ]; then
    sudo yum install -y cppcheck
else
    echo "Script does not handle system: ${OS_RELEASE}"
    exit 1
fi

pip3 install --user cpplint cppclean
