#!/bin/bash

service mariadb start

while ! mysqladmin ping --silent; do sleep 1; done

# mysqladmin -u $MYSQL_ROOT -p"$MYSQL_ROOT_PASSWORD" password $MYSQL_ROOT_PASSWORD

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" > /tmp/data.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> /tmp/data.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> /tmp/data.sql
echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;" >> /tmp/data.sql
echo "FLUSH PRIVILEGES;" >> /tmp/data.sql 
mysql < /tmp/data.sql

service mariadb stop

mysqld
