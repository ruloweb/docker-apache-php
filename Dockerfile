FROM debian:jessie

RUN apt-get update

RUN apt-get install -y apache2 curl git mysql-client php5 php5-mysql php5-curl php5-xdebug php5-gd vim wget

RUN a2enmod rewrite

COPY 99-drupal.ini /etc/php5/apache2/conf.d/
COPY 99-drupal.ini /etc/php5/cli/conf.d/

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer && \
    php -r "unlink('composer-setup.php');"

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
