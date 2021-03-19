FROM php:7.4

RUN set -xe 
RUN apt-get update -yqq
RUN apt-get install git -yqq
RUN apt-get install libmcrypt-dev -yqq
RUN apt-get install libzip-dev -yqq
RUN apt-get install libgmp-dev -yqq
RUN docker-php-ext-install zip
RUN pecl install mcrypt-1.0.3
RUN docker-php-ext-enable mcrypt
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install gmp
RUN pecl install redis-5.3.0
RUN pecl install xdebug-2.9.6
RUN docker-php-ext-enable redis xdebug
RUN apt-get install wget -yqq
RUN wget https://composer.github.io/installer.sig -O - -q | tr -d '\n' > installer.sig
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === file_get_contents('installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php'); unlink('installer.sig');"
RUN php --ini