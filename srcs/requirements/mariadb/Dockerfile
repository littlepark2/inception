FROM debian:bullseye

RUN apt-get update && apt-get install mariadb-server sudo vim -y

COPY ./tools/db.sh /

RUN chmod +x /db.sh

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chown -R mysql:mysql /var/lib/mysql /etc/mysql/mariadb.conf.d

RUN chmod -R 755 /var/lib/mysql /etc/mysql/mariadb.conf.d

ENTRYPOINT [ "sh", "/db.sh" ]
