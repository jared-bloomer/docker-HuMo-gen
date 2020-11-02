FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt install apache2 php mariadb-server mariadb-client -y
COPY humogen/ /var/www/html/
RUN echo "" >> /var/www/html/admin/php.ini && echo "extension=pdo.so" >> /var/www/html/admin/php.ini && echo "extension=pdo_sqlite.so" >> /var/www/html/admin/php.ini && echo "extension=pdo_mysql.so" >> /var/www/html/admin/php.ini
RUN echo "" >> /var/www/html/php.ini && echo "extension=pdo.so" >> /var/www/html/php.ini && echo "extension=pdo_sqlite.so" >> /var/www/html/php.ini && echo "extension=pdo_mysql.so" >> /var/www/html/php.ini

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
CMD ["/bin/bash", "/entrypoint.sh"]
RUN a2enmod rewrite
EXPOSE 80
EXPOSE 443
