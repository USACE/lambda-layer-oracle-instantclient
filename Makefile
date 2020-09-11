# The example repo at https://github.com/landrey21/aws-lambda-python-oracle and the Oracle docs at
# https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html#ic_x64_inst
# both mention needing to install `libaio` (or `libaio1`), and seem to make it sound like that must
# be installed on the *host* machine, before the Makefile runs... 

SHELL=/bin/bash
.PHONY: init package install clean

export ORACLE_HOME=$(PWD)/lib/

init:
	unzip "$(INSTANT_CLIENT_ZIP_DIR)/instantclient*.zip" -d /tmp/ 
	mv /tmp/$(INSTANT_CLIENT_DIR)/ ./lib/
#	ln -s ./libclntsh.so.18.1 ./lib/libclntsh.so # Gives a 'failed to create symbolic link ‘./lib/libclntsh.so’: File exists' error so not sure we need this step
	cp /lib64/libaio.so.1 ./lib/

lambda.zip: init
	zip -r $(BUILD_DIR)/$(BUILD_PACKAGE_NAME) lib
	echo "Package zip file created at $(BUILD_DIR)/$(BUILD_PACKAGE_NAME)"

package: lambda.zip

# I commented this out since it looks like instrumentation-api deploys via S3 rather than using update-function-code…
#install: lambda.zip
#  aws lambda update-function-code --function-name pythonOracleTest --zip-file fileb://$(BUILD_PACKAGE_NAME) --publish

#deploy: package
#	aws s3 cp $(BUILD_PACKAGE_NAME) s3://a2w-lambda-zips/$(BUILD_PACKAGE_NAME)

clean:
	rm -rf ./lib;
	rm -rf ./$(BUILD_PACKAGE_NAME);


# To access Docker container files?
# https://stackoverflow.com/questions/33848947/accessing-docker-container-files-from-windows
