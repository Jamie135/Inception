FROM	debian:buster

RUN	apt-get update -y && apt-get install -y wget \
	php7.3 \
	php-fpm \
	php-mysql \
	mariadb-client

#Download WordPress
RUN	wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

#Decompress
RUN	cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R root:root /var/www/wordpress

#Download CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar
RUN	mv wp-cli.phar /usr/local/bin/wp

COPY	/conf/auto_config.sh /usr/local/bin/
RUN	chmod +x /usr/local/bin/auto_config.sh

RUN	echo "listen=9000" >> /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT	["/conf/auto_config.sh"]
EXPOSE	9000