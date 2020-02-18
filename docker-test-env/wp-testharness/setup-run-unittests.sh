#!/bin/sh -l



# loop through plugins creating 
cur_dir=$PWD
failures=0;

for plugin_path in /var/www/html/wp-content/plugins/*/ ; do
    plugin_name=$(basename $plugin_path)
    echo $plugin_name
    
    # Create the database for this plugin
    cd /var/www/html/wp-content/plugins/$plugin_name
    
    # Run the test
    phpunit 
    
    # Increment failure count 
    if [ 0 != $? ]
    then
        failures=failures=0+1;
    fi
    

done

cd $cur_dir

# Report failures
if [ 0 != $failures ]
then
    echo "UNIT TESTS: FAILED"
    exit 1
else 
    echo "UNIT TESTS: PASSED"
    exit 0
fi
    


