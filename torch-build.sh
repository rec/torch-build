#!/bin/bash
set -e

# conda and the env vars are set correctly in pytorch-build.py
export BUILD_SOX=0
PKGS=(data vision audio)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $SCRIPT_DIR/pytorch-build.sh $@
pushd ${PYTORCH_BUILD_DIRECTORY:=~/git$PYTORCH_BUILD_SUFFIX}
rm -rf torch-vision/build

for pkg in ${PKGS[@]}; do
  pip uninstall -y "torch${pkg}"
  pushd "torch-${pkg}"
  pip install . --no-build-isolation -v
  popd
done

pip uninstall -y torchbenchmark
cd torchbenchmark
python install.py

popd
