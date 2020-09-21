#!/bin/bash

# Get Instantclient
wget -O instantclient.zip ${INSTANT_CLIENT_DOWNLOAD_URL}

# Make Working Directories
rm -rf build tmp; mkdir -p build/bin build/lib tmp

# Unzip Instant Client; -j drops all directory structure, keeps files
unzip -j instantclient.zip -d ./tmp/

# Copy in all required .so
cp /lib64/libaio.so.1 ./tmp/*.so* build/lib/

# Zip it
cd build \
  && zip -ruq ../${BUILD_PACKAGE_NAME} ./ \
  && cd ..
  
# Cleanup
rm -rf build tmp instantclient.zip
