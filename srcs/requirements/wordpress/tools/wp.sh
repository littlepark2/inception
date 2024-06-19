#!/bin/bash

mkdir -p /var/www/html/error

until mysql -h"mariadb" -u "$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;" | grep -q "$DB_NAME"; do
 echo "Waiting for WordPress database creation..." > /var/www/html/error/log.txt
 sleep 3
done

echo "connect to WordPress database" >> /var/www/html/error/log.txt
sleep 3

if [ ! -f /var/www/html/wp-config.php ] || ! mysql -h"mariadb" -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -e "SHOW TABLES;" | grep -q -E "(wp_posts|wp_users|wp_options)"; then
 echo "Create wordpress Data" >> /var/www/html/error/log.txt
 cd /var/www/html && \
 sudo -u www-data wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --path=/var/www/html --skip-check >> /var/www/html/error/log.txt
 cd /var/www/html && \
 sudo -u www-data -s wp core install --url=localhost --title="My WordPress Site" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --locale=ko_KR >> /var/www/html/error/log.txt
 cd /var/www/html/ && \
 sudo -u www-data -s wp user create $WORDPRESS_USER $ID@example.com --user_pass=$WORDPRESS_USER_PASSWORD >> /var/www/html/error/log.txt
fi

php-fpm7.4 -F
