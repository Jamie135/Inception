#!/bin/bash

service mariadb start;

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"	#Je demande de créer une table si elle n’existe pas déjà, du nom de la variable d’environnement SQL_DATABASE, indiqué dans mon fichier .env qui sera envoyé par le docker-compose.yml
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';" #Je crée l’utilisateur SQL_USER s’il n’existe pas, avec le mot de passe SQL_PASSWORD , toujours à indiquer dans le .env
mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" #Je donne les droits à l’utilisateur SQL_USER avec le mot de passe SQL_PASSWORD pour la table SQL_DATABASE
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL__ROOT_PASSWORD}';"
mariadb -e "FLUSH PRIVILEGES;"

#Redemarrage de MySQL
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
mysqld_safe