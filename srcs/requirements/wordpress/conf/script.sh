#!/bin/bash

# Configure WordPress

wp core download --path=/var/www/html --allow-root
rm -rf /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html
wp config create --dbname=$DB_NAME --dbuser=$DB_USER_NAME --dbpass=$DB_USER_PASS --dbhost=$HOST --path=/var/www/html/ --allow-root --skip-check --extra-php <<PHP
define('WP_CACHE', true);
define('WP_REDIS_HOST', 'redis');
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );
PHP

wp core install --url=iomayr.42.fr --title=Example --admin_user=ibra --admin_password=123456 --admin_email=ibra@gmail.com --path=/var/www/html/ --allow-root
wp user create brahim user@gmail.com --role=author --user_pass=123456 --allow-root --path=/var/www/html/

# the file /var/run/php/ will be created automatically when you run php service
service php7.3-fpm start
wp plugin install redis-cache --path=/var/www/html --activate --allow-root 
wp redis enable --path=/var/www/html/ --allow-root
service php7.3-fpm stop
# tail -f /dev/null
# /usr/sbin/php-fpm;
php-fpm7.3 -F