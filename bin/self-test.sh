#!/bin/sh -l

echo 'checking params'

# Running from the root of the folder
if [ 'wp-plugin-test-env' != $(basename $PWD) ]
then
    echo 'Please run this from the root of wp-plugin-test-env'
    exit
fi


# Clean anything dangling around from prior runs
./bin/tear-down-test-env.sh

# Build the docker - here we specifc the path to our example plugin
./bin/make-wp-docker.sh $PWD/example-plugin

# Spin up
./bin/bring-up-test-env.sh

# Run the tests - this will launch phpunit on all the test cases - return code will indicate success failure 
./bin/run-tests.sh

# Clean up
./bin/tear-down-test-env.sh



