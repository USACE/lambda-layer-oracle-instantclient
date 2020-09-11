FROM lambci/lambda:build-provided

# Install system libraries
RUN \
  yum makecache fast; \
  yum install -y libaio \
  yum clean all; \
  yum autoremove
    
# To find where libaio was installed: rpm -ql libaio

#WORKDIR /build
WORKDIR /src

# Paths
ENV \
  INSTANT_CLIENT_ZIP_DIR=./oracle \
  INSTANT_CLIENT_DIR=instantclient_18_5 \
  BUILD_DIR=/build \
  NPROC=1 \
  BUILD_PACKAGE_NAME=lambda-oracle-instantclient.zip

# Copy Code to Container
ADD . .

RUN \
  mkdir ${BUILD_DIR}; \
  make -j ${NPROC} package
    
CMD ["/bin/bash"]