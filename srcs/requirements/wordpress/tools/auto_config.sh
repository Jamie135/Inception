#!/bin/bash

#change working dir to where all the wordpress files are
cd /var/www/html

# give MariaDB time to lauch correctly:
sleep 10

#if there is no wordpress config: create one. 
# Use the MariaDB credentials and the networkport 3306 to set it up
if [ ! -e /var/www/html/wp-config.php ]; then
	wp config create --allow-root \
									  --dbname=$MYSQL_DATABASE \
									  --dbuser=$MYSQL_USER \
									  --dbpass=$MYSQL_PASSWORD \
									  --dbhost=mariadb:3306
fi

# This command installs WordPress with the specified parameters like site URL,
# site title, admin username, password, and email. This sets up the initial
# configuration of the WordPress site.
wp core install --url="$DOMAIN_NAME" \
							  --title=Inception \
							  --admin_user="$WP_ADMIN_NAME" \
							  --admin_password="$WP_ADMIN_PASSWORD" \
							  --admin_email="$WP_ADMIN_EMAIL" \
							  --allow-root

# create a new wordpress user with the credentials from the .env
wp user create --allow-root $WP_USER_NAME $WP_USER_EMAIL \
							   --role=editor \
							   --user_pass=$WP_USER_PASSWORD \

# create dir if not existant
if [ ! -d /run/php ]; then
	mkdir /run/php
fi

# start the fast cgi process manager and run it in the foreground
/usr/sbin/php-fpm7.4 -F

# #!/bin/sh

# sleep   10 #Assurer que la base de donnees MariaDB a eu le temps de se lancer correctement

# #Allow the auto-completion of WordPress pages at startup
# wp  config create	--allow-root \
# 					--dbname=$MYSQL_DATABASE \
# 					--dbuser=$MYSQL_USER \
# 					--dbpass=$MYSQL_PASSWORD \
# 					--dbhost=mariadb:3306 --path='/var/www/wordpress'

# wp core install --allow-root --path=/var/www/html/wordpress \
#                 --url=https://localhost/ \
# 	            --title=Inception \
# 	            --admin_user=$WP_ADMIN_NAME \
# 	            --admin_password=$WP_ADMIN_PASSWORD \
# 	            --admin_email=$WP_ADMIN_EMAIL \
# 	            --skip-email

# wp user create --allow-root --path=/var/www/html/wordpress $WP_USER_NAME $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD

# mkdir   -p /run/php
# exec    /usr/sbin/php-fpm7.3 -F