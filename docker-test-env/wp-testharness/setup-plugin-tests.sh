#!/bin/sh -l

# Install svn amd mysql admin 
apt-get update --assume-yes
apt-get install subversion --assume-yes
apt-get install mysql\* --assume-yes

#  Delete akismet
rm -fr /var/www/html/wp-content/plugins/akismet

# loop through plugins creating 
for plugin_path in /var/www/html/wp-content/plugins/*/ ; do
    plugin_name=$(basename $plugin_path)
    echo $plugin_name
    
    # Create plugin unit test scaffolding for each plugin 
    wp scaffold plugin-tests $plugin_name --allow-root
    
    # Create the database for this plugin
    /var/www/html/wp-content/plugins/$plugin_name/bin/install-wp-tests.sh $plugin_name-testdb root root db 

done



