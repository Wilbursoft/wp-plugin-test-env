#!/bin/sh -l


# Running from the root of the folder
if [ 'wp-plugin-test-env' != $(basename $PWD) ]
then
    echo 'Please run this from the root of wp-plugin-test-env'
    exit
fi

# Check plugin path exists
plugin_path_to_test=$1
if ! test -d "$plugin_path_to_test"; then
    echo "Path to plugin '$plugin_path_to_test' does not exist or was not specified."
    exit
fi

 

plugin_name=$(basename $plugin_path_to_test) 

workingdir=.
builddir=$workingdir/build

echo 'Cleaning then creating directories'
rm -fr $builddir/docker-test-env
mkdir -p $builddir/docker-test-env/wp-testharness

echo 'copying in docker files'
cp -r $workingdir/docker-test-env/wp-testharness $builddir/docker-test-env
cp -r $workingdir/docker-test-env/*.* $builddir/docker-test-env

echo 'copying in plugin files'
targetplugindir=$builddir/docker-test-env/wp-testharness/plugins/
mkdir -p $targetplugindir
cp -rf $plugin_path_to_test $targetplugindir

echo 'cleaning out existing unit test scaffolding '
rm $targetplugindir/$plugin_name/tests/bootstrap.php
rm $targetplugindir/$plugin_name/phpunit.xml.dist
rm $targetplugindir/$plugin_name/bin/install-wp-tests.sh

echo 'preparing phpunit'
wget --output-document=$builddir/docker-test-env/wp-testharness/phpunit-6.5.phar https://phar.phpunit.de/phpunit-6.5.phar 
chmod +x $builddir/docker-test-env/wp-testharness/phpunit-6.5.phar

echo 'preparing word press client'
wget --output-document=$builddir/docker-test-env/wp-testharness/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x $builddir/docker-test-env/wp-testharness/wp-cli.phar

echo 'building docker'
docker build $builddir/docker-test-env/wp-testharness -t wp-testharness

echo 'purging'
rm -fr $builddir/
