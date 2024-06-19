FROM debian:bullseye

RUN apt-get update && apt-get install mariadb-server -y

COPY ./tools/db.sh /

RUN chmod +x /db.sh

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chown -R mysql:mysql /etc/mysql/mariadb.conf.d/

RUN chmod 755 /etc/mysql/mariadb.conf.d/

CMD [ "/db.sh" ]
