#!/bin/bash

# Build GDAL Base Container
docker build . -t lambda-layer-oracle-instantclient:latest
docker run --rm \
    -v ${PWD}:/home/src \
    -t lambda-layer-oracle-instantclient:latest package.sh