FROM debian:bullseye

RUN apt-get update && apt-get install php php-fpm php-mysql mariadb-client sudo curl -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && sudo mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php && \
	chown -R www-data:www-data /run/php && \
	chmod -R 755 /run/php

RUN mkdir -p /var/www/html && \
	chown -R www-data:www-data /var/www/html && \
	chmod -R 755 /var/www/html

RUN cd /var/www/html && \
	curl -O https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz && \
	rm latest.tar.gz && \
	mv wordpress/* . && \
	rm -rf wordpress

RUN sed -i "s/listen =.*/listen = 9000/g" /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/new.sh /new.sh

RUN chmod +x /new.sh

CMD [ "sh", "/new.sh" ]
