#!/bin/bash

# Get Instantclient
wget -O instantclient.zip ${INSTANT_CLIENT_DOWNLOAD_URL}

# Make Working Directories
rm -rf lib tmp; mkdir lib tmp

# Unzip Instant Client; -j drops all directory structure, keeps files
unzip -j instantclient.zip -d ./tmp/

# Change Directory into lib; Copy in all required .so; zip
cd lib \
  && cp ../tmp/*.so* ./ \
  && cp /lib64/libaio.so.1 ./ \
  && zip -ruq ../${BUILD_PACKAGE_NAME} ./ \
  && cd ..

# Cleanup
rm -rf lib tmp instantclient.zip
