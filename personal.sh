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

popd
