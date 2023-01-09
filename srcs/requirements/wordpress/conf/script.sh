#!/bin/bash

# Configure WordPress
wp core download --path=/var/www/html --allow-root
rm -rf /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
wp config create --dbname=$DB_NAME --dbuser=$DB_USER_NAME --dbpass=$DB_USER_PASS --dbhost=$DB_HOST --path=/var/www/html/ --allow-root --skip-check --extra-php <<PHP
define('WP_CACHE', true);
define('WP_REDIS_HOST', 'redis');
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );
PHP

wp core install --url=$URL --title=$TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --path=/var/www/html/ --allow-root
wp user create brahim user@gmail.com --role=author --user_pass=$WP_USER_PASS --allow-root --path=/var/www/html/

# the file /var/run/php/ will be created automatically when you run php service
service php7.3-fpm start
wp plugin install redis-cache --path=/var/www/html --activate --allow-root 
wp redis enable --path=/var/www/html/ --allow-root
service php7.3-fpm stop
chown -R www-data:www-data -f /var/www/html 

# /usr/sbin/php-fpm;
php-fpm7.3 -F