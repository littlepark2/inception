#!/bin/bash

service mariadb start;

sleep 3;

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	touch /var/lib/mysql/success.txt
	mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
	mysql -e "FLUSH PRIVILEGES;"
fi

service mariadb stop;

exec mysqld_safe;

