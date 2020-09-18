FROM lambci/lambda:build-provided

# Install system libraries
RUN \
  yum makecache fast; \
  yum install -y libaio wget \
  yum clean all; \
  yum autoremove
    
# To find where libaio was installed: rpm -ql libaio

#WORKDIR /build
WORKDIR /home/src

# Paths
ENV \
  INSTANT_CLIENT_DOWNLOAD_URL="https://download.oracle.com/otn_software/linux/instantclient/185000/instantclient-basiclite-linux.x64-18.5.0.0.0dbru.zip" \
  BUILD_PACKAGE_NAME=lambda-layer-oracle-instantclient-18.5.0.0.0.zip \
  PATH="$PATH:/home/src"

COPY package.sh .
