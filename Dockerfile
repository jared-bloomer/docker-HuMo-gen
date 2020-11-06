FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt install apache2 php libapache2-mod-php mariadb-server mariadb-client php-mysql php-sqlite3 php-curl -y
COPY humogen/ /var/www/html/
RUN sed -i '/extension\=pdo_mysql/s/^\;//g' /etc/php/7.4/apache2/php.ini && \
    sed -i '/extension\=pdo_sqlite/s/^\;//g' /etc/php/7.4/apache2/php.ini && \
    sed -i '/extension=curl/s/^\;//g' /etc/php/7.4/apache2/php.ini
RUN echo "" >> /var/www/html/admin/php.ini && echo "extension=pdo" >> /var/www/html/admin/php.ini && \
    echo "extension=pdo_sqlite" >> /var/www/html/admin/php.ini && \
    echo "extension=pdo_mysql" >> /var/www/html/admin/php.ini
RUN echo "" >> /var/www/html/php.ini && echo "extension=pdo" >> /var/www/html/php.ini && \
    echo "extension=pdo_sqlite" >> /var/www/html/php.ini && \
    echo "extension=pdo_mysql" >> /var/www/html/php.ini
RUN chown -R www-data:www-data /var/www/html/*

COPY setupDB.sh /
RUN chmod 755 /setupDB.sh

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash", "/setupDB.sh"]
RUN a2enmod rewrite
EXPOSE 80
EXPOSE 443
