FROM php:7.2-fpm
MAINTAINER Piero Recchia <www.pierorecchia.com>

RUN apt-get update && apt-get install -y  zlib1g-dev libicu-dev libpq-dev imagemagick git mysql-client\
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install intl \
        && docker-php-ext-install zip \
	&& docker-php-ext-install pdo_mysql \
	&& pecl install xdebug \
    && docker-php-ext-enable xdebug \
	&& php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	&& chmod +sx /usr/local/bin/composer

EXPOSE 9000
