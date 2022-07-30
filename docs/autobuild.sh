#!/bin/bash

# Initial Build
make clean
make html
firefox "http://127.0.0.1:8000" &
sphinx-autobuild source build/html
