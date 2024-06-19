#!/bin/bash

mkdir -p /var/www/html/error

until mysql -h "mariadb" -u"$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;" | grep -q "$DB_NAME"; do
    echo "Waiting for WordPress database creation..." > /var/www/html/error/log.txt
    sleep 5
done

if [ ! -f "/var/www/html/wp-config.php" ]; then
    cd /var/www/html

    sudo -u www-data wp core download

    sudo -u www-data wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --dbhost=mariadb --path=/var/www/html >> /var/www/html/error/log.txt
    sudo -u www-data wp core install --url=localhost --title=wordpress --admin_user=${WORDPRESS_ADMIN_USER} --admin_password=${WORDPRESS_ADMIN_PASSWORD} --admin_email=${WORDPRESS_ADMIN_EMAIL} --path=/var/www/html >> /var/www/html/error/log.txt
    sudo -u www-data wp user create ${WORDPRESS_USER} user2@example.com --role=author --user_pass=${WORDPRESS_USER_PASSWORD} --path=/var/www/html
fi

php-fpm7.4 -F
