#!/bin/sh -l

echo 'checking params'

# Running from the root of the folder
if [ 'wp-plugin-test-env' != $(basename $PWD) ]
then
    echo 'Please run this from the root of wp-plugin-test-env'
    exit
fi


# Clean anything dangling out
./bin/tear-down-test-env.sh

# Build the docker
./bin/make-wp-docker.sh $PWD/example-plugin

# Spin up
./bin/bring-up-test-env.sh

# Run the tests
docker exec docker-test-env_wordpress_1 /var/www/html/setup-run-unittests.sh 


# Clean up
echo "run ./bin/tear-down-test-env.sh to clean up"



