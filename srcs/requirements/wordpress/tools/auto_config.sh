#!/bin/bash

if [ -f "/var/www/html/wp-config.php" ]
then
	echo "WordPress is already set"
else
	sleep 10
	./wp-cli.phar config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$WP_DB_HOST --path='/var/www/html'
	chmod 777 /var/www/html/wp-config.php
	chown -R root:root /var/www/html
	./wp-cli.phar core install --allow-root --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --path='/var/www/html'
	./wp-cli.phar user create $WP_USER_NAME $WP_USER_EMAIL --allow-root --role=author --user_pass=$WP_USER_PASSWORD --path='/var/www/html'
fi

exec /usr/sbin/php-fpm7.4 -F;