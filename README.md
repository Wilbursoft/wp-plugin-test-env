# wp-plugin-test-env
Spins up a docker based test environment for testing WordPress plugins.  
Designed to be used locally in a dev environmnet or as a part of a CI/CD workflow (e.g. GitHub Actions). 

# Description
The scripts create a WordPress docker with your plugin code, phpunit-6.5 and supporting WordPress scaffolding auto configured ready to run tests. This is along with a mysql docker is spun up and configured with your plugin active. Tests are then run and when completed the setup is toen down. 

# Pre reqs
- docker, docker compose

# Usage
All runnable scripts are in /bin/ directory

### make-wp-docker.sh - Make the docker images needed 
    ./bin/make-wp-docker.sh [plugin path]

- [plugin path] is the absolute path to your plugin 
- Creates a docker image 'wp-testharness' locally
- Based on WordPress https://hub.docker.com/_/wordpress/
- Copys in you plugin code 
- Installs phpunit-6.5, wp-cli ready for WP_UnitTestCase and TestCase test cases 

### bring-up-test-env.sh - Bring up the test environment 
    ./bin/bring-up-test-env.sh
    
- Brings up two docker test environment wp-testharness and seperate mysql instance configured and ready for test


    | CONTAINER ID        IMAGE               COMMAND                   PORTS                  NAMES
    | 3333923afeda        mysql:5.7           "docker-entrypoint.s…"    3306/tcp, 33060/tcp    docker-test-env_db_1
    | 95bbd1f6efd7        wp-testharness      "docker-entrypoint.s…"    0.0.0.0:8080->80/tcp   docker-test-env_wordpress_1
    

- Wordpress will listen on http://localhost:8080 from the docker host
- To get a shell on the word press docker run
 
    $ docker exec -it docker-test-env_wordpress_1 /bin/bash


### ./bin/tear-down-test-env.sh Tears down the docker environment 
    ./bin/tear-down-test-env.sh
- tears down the created test environment and prunes out related images, volumes etc. 
- WARNING: Everything is gone.

### self-test.sh Self test 
    ./bin/self-test.sh
- a script to test this the too set, copied below as a good example of how to use locally


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

### Example GitHub Action Usage
 
- an example of GitHug work flow *.yml file 


    name: Automates Test On Push
    on: [push]
    jobs:
      unit-test:
        runs-on: ubuntu-latest
        name: Run unit test with coverage
        steps:
          
          - name: Checkout WordPress plugin code 
            uses: actions/checkout@v2
            with:
              path: my-plugin
    
          - name: Checkout wp-plugin-test-env
            uses: actions/checkout@v2
            with:
              repository: Wilbursoft/wp-plugin-test-env
              path: wp-plugin-test-env
    
          - name: Run tests
            run: |
              echo creating docker image for test environment
              cd ./wp-plugin-test-env
              ./bin/make-wp-docker.sh ../my-plugin
              
              echo spinning up test environment 
              ./bin/bring-up-test-env.sh
              cd ..
              
              echo Run the tests
              docker exec docker-test-env_wordpress_1 /var/www/html/setup-run-unittests.sh 
              exit $?


