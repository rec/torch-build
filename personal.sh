#!/bin/bash

set -ex

if [ ! "$SSH_AUTH_SOCK" ] ; then
    echo 'SSH_AUTH_SOCK is not set'
    exit -1
fi

mkdir -p ~/code
pushd ~/code

for repo in dotfiles gitz psplit test ; do
    git clone git@github.com:rec/$repo.git
done


git config --global user.email "tom@swirly.com"
git config --global user.name "Tom Ritchford"

export PYTORCH_GIT_BRANCH=typing
export PYTORCH_GIT_USER=rec
export PYTORCH_BUILD_DIRECTORY=$(pwd)

popd
