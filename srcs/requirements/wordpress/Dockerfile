FROM	debian:bullseye

RUN		mkdir -p /var/www/html \
		&& mkdir -p /run/php

RUN		apt-get update -y \
		&& apt-get upgrade -y \
		&& apt-get install wget -y \
		&& apt-get install -y php7.4 php-fpm php-mysql php-common php-cgi php-cli mariadb-client vim

EXPOSE	9000

RUN		wget https://fr.wordpress.org/wordpress-6.2.2-fr_FR.tar.gz -P /var/www \
		&& tar -xzf /var/www/wordpress-6.2.2-fr_FR.tar.gz -C /var/www/. \
		&& cp -r /var/www/wordpress/. /var/www/html \
		&& rm /var/www/wordpress-6.2.2-fr_FR.tar.gz

RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN 	chmod +x wp-cli.phar

COPY	conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY 	tools/auto_config.sh auto_config.sh

RUN		chmod +x auto_config.sh
