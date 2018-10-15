FROM php:alpine
RUN echo -e "http://mirrors.aliyun.com/alpine/latest-stable/main\nhttp://mirrors.aliyun.com/alpine/latest-stable/community" > /etc/apk/repositories \
    && cd /usr/local/bin \
    && apk add build-base shadow openssh bash libxml2-dev openssl-dev libjpeg-turbo-dev libpng-dev libxpm-dev freetype-dev gd-dev gettext-dev libmcrypt-dev binutils libmcrypt libjpeg libjpeg-turbo-dev \
    && ./docker-php-ext-install redis \
    && ./docker-php-ext-install iconv \
    && ./docker-php-ext-install pdo_mysql \
    && ./docker-php-ext-install bcmath \
    && ./docker-php-ext-install sockets \
    && ./docker-php-ext-install mysqli \
    && ./docker-php-ext-install shmop \
    && ./docker-php-ext-install gd \
    && ./docker-php-ext-install pcntl \
    && ./docker-php-ext-install soap \
    && ./docker-php-ext-install zip \
    && ./docker-php-ext-install xmlrpc
