FROM debian:jessie

RUN apt-get update

RUN apt-get install -y wget

RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list && \
    echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list && \
    wget -qO - https://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
    apt-get update

RUN apt-get install -y apache2 curl git mysql-client php7.0 php7.0-mbstring php7.0-mysql php7.0-curl php7.0-xdebug php7.0-gd php7.0-xml vim

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
