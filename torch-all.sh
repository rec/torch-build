#!/bin/bash

set -ex

ROOT=$( pwd )

MINICONDA=$ROOT/miniconda3

if [! -e $MINICONDA/bin/conda ]; then
    MC_SCRIPT=$MINICONDA/miniconda.sh
    URL_TO_CONDA=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

    mkdir -p $MINICONDA
    curl -o $MC_SCRIPT $URL_TO_CONDA
    bash $MC_SCRIPT -b -p $MINICONDA
    rm $MC_SCRIPT
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/torch-clone.sh

if [[ $PYTORCH_GIT_BRANCH ]]; then
    pushd pytorch
    git checkout $PYTORCH_GIT_BRANCH
    popd
fi

source $SCRIPT_DIR/torch-env.sh
source $SCRIPT_DIR/torch-build.sh
