FROM	debian:bullseye

#Install NGINX
RUN apt-get -y update && apt-get -y upgrade && \
	apt-get install nginx -y && apt-get install vim -y && \
	apt-get install curl -y

RUN chown -R www-data:www-data /var/www/html && \
	chmod 755 /var/www/html

#Create a self-signed SSL certificate (you can replace this with your own certificate)
RUN mkdir -p /etc/nginx/ssl

RUN apt-get -y install openssl

RUN openssl req -x509 \
				-nodes \
				-out /etc/nginx/ssl/inception.crt \
				-keyout /etc/nginx/ssl/inception.key \
				-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pbureera.42.fr/UID=pbureera"

#Expose ports
EXPOSE 443

#Copy the NGINX configuration file to the container
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

#Start NGINX daemon
CMD [ "nginx", "-g", "daemon off;" ]