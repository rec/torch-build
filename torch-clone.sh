#!/bin/bash
set -e

mkdir -p ${PYTORCH_BUILD_DIRECTORY:=~/git$PYTORCH_BUILD_SUFFIX}
pushd $PYTORCH_BUILD_DIRECTORY

# PyTorch
git clone ${PYTORCH_GIT_PREFIX:=git@github.com:}${PYTORCH_GIT_USER:=pytorch}/pytorch.git

pushd pytorch
if [ "$PYTORCH_GIT_USER" != "pytorch" ]; then
    git remote add upstream ${PYTORCH_GIT_PREFIX}pytorch/pytorch.git
fi

git fetch
git submodule update --init --recursive

popd

# Domain Libraries
PKGS=(data vision text audio)
for pkg in ${PKGS[@]}; do
	git clone ${PYTORCH_GIT_PREFIX}pytorch/${pkg}.git "torch-${pkg}"
done

# pytorch/benchmark needs to have the name torchbenchmark and be in the same
# folder as PyTorch, otherwise benchmarks/dynamo/torchbench.py won't find it
git clone ${PYTORCH_GIT_PREFIX}pytorch/benchmark.git "torchbenchmark"

popd
