#!/bin/sh

sleep   10 #Assurer que la base de donnees MariaDB a eu le temps de se lancer correctement

#Allow the auto-completion of WordPress pages at startup
wp  config create	--allow-root \
					--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install --allow-root --path=/var/www/html/wordpress \
                --url=https://localhost/ \
	            --title=Inception \
	            --admin_user=$WP_ADMIN_NAME \
	            --admin_password=$WP_ADMIN_PASSWORD \
	            --admin_email=$WP_ADMIN_EMAIL \
	            --skip-email

wp user create --allow-root --path=/var/www/html/wordpress $WP_USER_NAME $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD

mkdir   -p /run/php
exec    /usr/sbin/php-fpm7.3 -F