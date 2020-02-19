# wp-plugin-test-env
Spins up a docker based test environment for testing WordPress plugins.  Designed to be used locally in a dev environmnet or as a part of a CI/CD workflow. 

# Description
The scripts create a WordPress docker with your plugin code, phpunit-6.5 and supporting WordPress scaffolding auto configured ready to run tests. This is along with a mysql docker is spun up and configured with your plugin active. Tests are then run and when completed the setup is toen down. 

# Pre reqs
- docker, docker compose

# Usage
All runnable tools are in /bin

### Make the docker images needed 
    ./bin/make-wp-docker.sh [plugin path]
- creates a docker image 'wp-testharness' locally
- image contains WordPress, your plugin code and all the Word Press unit test framework configured

### Bring up the test environment 
    ./bin/bring-up-test-env.sh
- brings up the test environment wp-testharness and seperate mysql instance configured and ready for test
- it will listen on http://localhost:8080
- To get a shell on the word press docker run
 
    $ docker exec -it docker-test-env_wordpress_1 /bin/bash
    root@5e21dd76a0ae:/var/www/html# 


### Tear down the test environment 
    ./bin/tear-down-test-env.sh
- tears down the test environment and prunes out images, volumes etc. 

### Self test 
    ./bin/self-test.sh
- a script to test this the end process is working correclty using the test plugin. 
- also a good example on how to use wp-plugin-test-env as a part of your plugins build pipe line
