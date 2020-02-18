#!/bin/sh -l

# Running from the root of the folder
if [ 'wp-plugin-test-env' != $(basename $PWD) ]
then
    echo 'Please run this from the root of wp-plugin-test-env'
    exit
fi

echo 'Tearing down stack'
docker-compose -f ./docker-test-env/stack.yml down --volumes   --rmi all

