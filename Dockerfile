FROM daocloud.io/library/php:7.3.4-fpm-alpine
RUN echo -e "http://mirrors.aliyun.com/alpine/latest-stable/main\nhttp://mirrors.aliyun.com/alpine/latest-stable/community" > /etc/apk/repositories \
    && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && apk add icu-dev gd-dev gettext-dev freetype git libpng bzip2 libzip-dev libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libmemcached libmemcached-libs zlib zlib-dev libmemcached-dev cyrus-sasl-dev libxml2-dev libxslt-dev openssl-dev libffi-dev zlib-dev autoconf \
    && docker-php-ext-install soap gettext mysqli shmop sysvsem sockets bcmath iconv iconv mbstring opcache pdo pdo_mysql gd \
    && pecl install igbinary \
    && docker-php-ext-enable igbinary \
    && pecl install redis \
    && pecl install swoole \
    && pecl install memcached \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer
