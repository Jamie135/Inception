FROM	debian:bullseye

#Install NGINX
RUN apt -y update && apt -y upgrade && \
	apt install nginx -y

RUN chown -R www-data:www-data /var/www/html && \
	chmod 755 /var/www/html

#Expose ports
EXPOSE 443

#Create a self-signed SSL certificate (you can replace this with your own certificate)
RUN mkdir -p /etc/nginx/ssl

RUN apt -y install openssl

RUN openssl req -newkey rsa:4096 -x509 \
				-days 365 \
				-nodes \
				-out /etc/nginx/ssl/inception.crt \
				-keyout /etc/nginx/ssl/inception.key \
				-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pbureera.42.fr/UID=pbureera"

RUN mkdir -p /run/nginx

#Copy the NGINX configuration file to the container
COPY ./conf/nginx.conf /etc/nginx/conf.d/server.conf

#Start NGINX daemon
CMD [ "nginx", "-g", "daemon off;" ]