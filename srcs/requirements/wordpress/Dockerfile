FROM	debian:bullseye

RUN	apt-get update -y && apt-get install -y wget \
	php7.4 \
	php7.4-fpm \
	php-mysql \
	mariadb-client

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

#Download WordPress then decompress
RUN	wget https://fr.wordpress.org/wordpress-6.3-fr_FR.tar.gz -P /var/www
RUN	cd /var/www && tar -xzf wordpress-6.3-fr_FR.tar.gz && rm wordpress-6.3-fr_FR.tar.gz
RUN	chown -R root:root /var/www/html

#Download CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar
RUN	mv wp-cli.phar /usr/local/bin/wp

COPY	./tools/auto_config.sh /usr/local/bin/
RUN	chmod +x /usr/local/bin/auto_config.sh

ENTRYPOINT	["bash", "/usr/local/bin/auto_config.sh"]
EXPOSE	9000