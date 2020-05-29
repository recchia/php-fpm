FROM php:7.4-fpm

MAINTAINER Piero Recchia <www.pierorecchia.com>

ENV ACCEPT_EULA=Y

RUN apt-get update && apt-get install -y gnupg2 \
        && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
        && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
        && apt-get install -y --no-install-recommends locales apt-transport-https \
        && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
        && locale-gen \
        && apt-get update \
        && apt-get -y --no-install-recommends install gnupg2 unixodbc-dev msodbcsql17 \
        && apt-get install -y  zlib1g-dev libicu-dev libpq-dev libzip-dev imagemagick git \
        && docker-php-ext-install opcache \
        && docker-php-ext-install intl \
        && docker-php-ext-install zip \
        && pecl install sqlsrv-5.8.1 pdo_sqlsrv-5.8.1 \
        && docker-php-ext-enable sqlsrv pdo_sqlsrv \
	    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	    && chmod +sx /usr/local/bin/composer

EXPOSE 9000
