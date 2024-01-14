# base image
FROM debian:bullseye

# install mariadb server
RUN apt update && apt install mariadb-server -y
RUN mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld
RUN mkdir -p /var/lib/mysql && chown mysql:mysql /var/lib/mysql
# configure mariadb to allow external connections
RUN  sed -i 's/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
# copy custom initialization script
COPY script.sh /tmp/

# make the script executable
RUN chmod 777 /tmp/script.sh

WORKDIR /tmp

ENTRYPOINT ["bash", "script.sh"]

CMD ["bash", "-c", "mysql < data.sql"]
