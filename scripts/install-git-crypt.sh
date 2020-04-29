#!/bin/bash
set -ex

REPO_URL="https://embeddedartistry.com/blog/2018/03/15/safely-storing-secrets-in-git/"
BUILD_DIR="`mktemp -d`"

cd $BUILD_DIR
git clone $REPO_URL

