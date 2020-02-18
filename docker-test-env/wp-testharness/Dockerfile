FROM wordpress:latest

# https://medium.com/@HappyGezim/testing-your-wordpress-plugin-using-docker-containers-d166651fc25b
RUN curl -LO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Plugin files  
COPY plugins/ /usr/src/wordpress/wp-content/plugins/

# phpunit 
COPY phpunit-6.5.phar /usr/local/bin/phpunit

# word press client 
COPY wp-cli.phar /usr/local/bin/wp

# setup scripts
COPY setup-* /usr/src/wordpress/

