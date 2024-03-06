#!/bin/bash

# Initial Build
make clean
make html
firefox "http://127.0.0.1:8000" &
sphinx-autobuild --port 8005 source build/html
