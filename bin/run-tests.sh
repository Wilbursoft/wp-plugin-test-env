#!/bin/sh -l

echo 'checking params'

# Running from the root of the folder
if [ 'wp-plugin-test-env' != $(basename $PWD) ]
then
    echo 'Please run this from the root of wp-plugin-test-env'
    exit
fi

# Run the tests
docker exec docker-test-env_wordpress_1 /var/www/html/setup-run-unittests.sh 
exit $?





