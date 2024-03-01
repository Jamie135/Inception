FROM	debian:bullseye

EXPOSE 3306

RUN     apt-get update -y && \
        apt-get upgrade -y && \
        apt-get install -y mariadb-server && \
        apt-get install -y mariadb-client

RUN     mkdir -p /var/run/mysqld && \
        chown -R mysql:mysql /var/run/mysqld && \
        chmod 777 /var/run/mysqld && \
        chown -R mysql:mysql /etc/mysql/

COPY	conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY	tools/mariadb.sh /tmp/mariadb.sh

RUN	chmod +x /tmp/mariadb.sh && \
    chown -R mysql:mysql /tmp/ && \
    chown -R mysql:mysql /etc/mysql

# ENTRYPOINT ["sh", "/tmp/mariadb.sh"]