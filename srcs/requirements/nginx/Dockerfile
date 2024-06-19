# base image
FROM debian:bullseye

# install nginx
RUN apt-get update && apt-get install nginx openssl -y

# copy directory
COPY conf /etc/nginx/conf.d
COPY certs /etc/nginx/ssl

RUN chown -R www-data:www-data /var/www/html && chmod 755 /var/www/html

# expose network port
EXPOSE 443

# run
CMD ["nginx" , "-g", "daemon off;"]
