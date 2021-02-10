FROM php:7.2-fpm-alpine
MAINTAINER Piero Recchia <www.pierorecchia.com>

RUN apk update && apk --no-cache add --virtual .build-deps $PHPIZE_DEPS \
    && apk add --no-cache autoconf zlib-dev icu-dev libpq libzip-dev imagemagick git mysql-client postgresql-dev \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install intl \
    && docker-php-ext-install zip \
	&& docker-php-ext-install pdo_mysql \
	&& pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del .build-deps \
	&& php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	&& chmod +sx /usr/local/bin/composer

EXPOSE 9000
