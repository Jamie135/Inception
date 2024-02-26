FROM	debian:buster

RUN apt -y update && apt -y upgrade && \
	apt install nginx -y && apt install vim -y

RUN chown -R www-data:www-data /var/www/html && \
	chmod 755 /var/www/html

RUN mkdir -p /etc/nginx/ssl

RUN apt -y install openssl

RUN openssl req -newkey rsa:4096 -x509 \
				-days 365 \
				-nodes \
				-out /etc/nginx/ssl/inception.crt \
				-keyout /etc/nginx/ssl/inception.key \
				-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/run/nginx

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]