#!/bin/bash

# Build GDAL Base Container
docker build . -t lambda-layer-oracle-instantclient:latest
docker run --rm \
    -v ${GITHUB_WORKSPACE}:/home/src \
    -t lambda-layer-oracle-instantclient:latest bin/package.sh

# Upload to S3
aws s3 cp ${GITHUB_WORKSPACE}/lambda-layer-oracle-instantclient-18.5.0.0.0.zip \
          s3://corpsmap-lambda-zips/lambda-layer-oracle-instantclient-18.5.0.0.0.zip
