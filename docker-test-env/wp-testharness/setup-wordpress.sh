#!/bin/sh -l

#  Setup up word press
wp core install --url=example.com --title="wp-plugin-test-env" --admin_user=admin --admin_email=admin@example.com  --allow-root    

#  Wait for it to go live
curl localhost | grep 'willnotfindstring'
while [ 0 != $? ]
do
    echo 'waiting for WordPress setup to complete'
    sleep 2
    curl localhost | grep '<title>wp-plugin-test-env'
done

