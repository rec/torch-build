#!/bin/bash
set -e

mkdir -p ${PYTORCH_PARENT:=~/.git}
cd $PYTORCH_PARENT

# PyTorch
git clone git@github.com:rec/pytorch.git

# Domain Libraries
PKGS=(data vision text audio)
for pkg in ${PKGS[@]}; do
	git clone git@github.com:pytorch/${pkg}.git "torch-${pkg}"
done

# torch/benchmarkBenchmark
# torchbenchmark needs to have this name and be in the same folder as
# PyTorch, otherwise benchmarks/dynamo/torchbench.py won't find it
git clone git@github.com:pytorch/benchmark.git "torchbenchmark"
