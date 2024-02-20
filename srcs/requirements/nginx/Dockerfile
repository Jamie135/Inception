FROM	debian:buster

RUN apt -y update && apt -y upgrade
RUN apt install nginx -y
RUN apt install vim -y

RUN chown -R www-data:www-data /var/www/html
RUN chmod 755 /var/www/html

RUN mkdir -p /etc/nginx/ssl

RUN apt install OpenSSL -y

RUN openssl req -x509 \
				-nodes \
				-out /etc/nginx/ssl/inception.crt \
				-keyout /etc/nginx/ssl/inception.key \
				-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/run/nginx

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]