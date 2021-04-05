FROM php:7.4-fpm-alpine
LABEL maintainer="Piero Recchia <www.pierorecchia.com>"

RUN apk update && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS zlib-dev icu-dev libpq libzip-dev \
    imagemagick git mysql-client \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pgsql pdo_pgsql \
	&& pecl install xdebug \
	&& docker-php-ext-enable xdebug \
	&& php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	&& chmod +sx /usr/local/bin/composer \
	&& apk del -f .build-deps

EXPOSE 9000
