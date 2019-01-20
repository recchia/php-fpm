FROM php:7.3-fpm

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
        && apt-get install -y  zlib1g-dev libicu-dev libpq-dev libzip-dev imagemagick git mysql-client\
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install intl \
        && docker-php-ext-install zip \
	&& docker-php-ext-install pdo_mysql \
        && pecl install sqlsrv-5.5.0preview pdo_sqlsrv-5.5.0preview \
        && docker-php-ext-enable sqlsrv pdo_sqlsrv \
	&& php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	&& chmod +sx /usr/local/bin/composer

RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

EXPOSE 9000
