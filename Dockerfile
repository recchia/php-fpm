FROM php:8.0-fpm-alpine
LABEL maintainer="Piero Recchia <www.pierorecchia.com>"

RUN apk update && apk add --no-cache zlib-dev icu-dev libpq libzip-dev imagemagick git mysql-client postgresql-dev \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install intl \
    && docker-php-ext-install zip \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pgsql pdo_pgsql \
	&& php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	&& chmod +sx /usr/local/bin/composer

EXPOSE 9000
