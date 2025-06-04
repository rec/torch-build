#!/bin/bash

set -ex

if [[ $1 ]]; then
    ROOT=$1
else
    ROOT=$(pwd)
fi

ROOT=${1:=$( pwd )}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/torch-clone.sh

if [[ $PYTORCH_GIT_BRANCH ]]; then
    pushd pytorch
    git checkout $PYTORCH_GIT_BRANCH
    popd
fi

export PYTORCH_BUILD_DIRECTORY=$( pwd )
source $SCRIPT_DIR/torch-env.sh
conda activate pytorch-dev
source $SCRIPT_DIR/torch-build.sh
