#!/bin/bash

set -ex

ROOT=$( pwd )

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/torch-clone.sh

if [[ $PYTORCH_GIT_BRANCH ]]; then
    pushd pytorch
    git checkout $PYTORCH_GIT_BRANCH
    popd
fi

export PYTORCH_BUILD_DIRECTORY=$( pwd )
source $SCRIPT_DIR/torch-env.sh
source $SCRIPT_DIR/torch-build.sh
