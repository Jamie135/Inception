FROM	debian:buster

RUN     apt-get update -y
RUN     apt-get upgrade -y
RUN     apt-get install -y mariadb-server
RUN     apt-get install -y mariadb-client

RUN     mkdir -p /var/run/mysqld && \
        chown -R mysql:mysql /var/run/mysqld && \
        chmod 777 /var/run/mysqld && \
        chown -R mysql:mysql /etc/mysql/

COPY	conf/mysql.cnf	/etc/mysql/mariadb.conf.d/mysql.cnf
COPY	tools/script.sh /tmp/script.sh

RUN	chmod +x /tmp/script.sh && \
    chown -R mysql:mysql /tmp/ && \
    chown -R mysql:mysql /etc/mysql

EXPOSE 3306

ENTRYPOINT ["sh", "/tmp/script.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]