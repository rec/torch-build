#!/bin/bash

set -ex

if [ "$1" ]; then
    ROOT="$1"
else
    ROOT=$(pwd)
fi

MINICONDA=$ROOT/miniconda3

if [ ! -e $MINICONDA/bin/conda ]; then
    MC_SCRIPT=miniconda.sh
    URL_TO_CONDA=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

    curl -o $MC_SCRIPT $URL_TO_CONDA
    bash $MC_SCRIPT -b -p $MINICONDA
    rm $MC_SCRIPT
fi

$MINICONDA/bin/conda init
