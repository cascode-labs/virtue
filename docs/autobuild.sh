#!/bin/bash
# Activate Build Env
BUILD_ENV_PREFIX="./../envs/virtue-build-docs"
BASE_ENV_PREFIX="/prj/ids/ids-conda/envs/IDS"
source "${BASE_ENV_PREFIX}/etc/profile.d/conda.sh"
conda activate "${BUILD_ENV_PREFIX}"

# Initial Build
make clean
make html
firefox "http://127.0.0.1:8000" &
sphinx-autobuild source build/html

conda deactivate
