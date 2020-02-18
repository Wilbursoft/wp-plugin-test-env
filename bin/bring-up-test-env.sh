#!/bin/sh -l

# Running from the root of the folder
if [ 'wp-plugin-test-env' != $(basename $PWD) ]
then
    echo 'Please run this from the root of wp-plugin-test-env'
    exit
fi


echo 'deploying stack'
docker-compose -f   ./docker-test-env/stack.yml up -d --force-recreate    


echo 'waiting for WordPress setup'
curl localhost | grep 'willnotfindstring'
while [ 0 != $? ]
do
    echo 'waiting for WordPress setup page'
    sleep 2
    curl localhost:8080/wp-admin/install.php | grep '<body class="wp-core-ui language-chooser">'
done

echo 'Setting up Word Press'
docker exec docker-test-env_wordpress_1 /var/www/html/setup-wordpress.sh


echo 'Setting up Word Press Plugin unit test scaffolding'
docker exec docker-test-env_wordpress_1 /var/www/html/setup-plugin-tests.sh

echo 'Done'
