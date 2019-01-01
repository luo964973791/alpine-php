FROM daocloud.io/library/php:7.3.0-fpm-alpine
ENV REDIS_VER redis-4.1.1
ENV MEMCACHED_VER memcached-3.0.4
RUN echo -e "http://mirrors.aliyun.com/alpine/latest-stable/main\nhttp://mirrors.aliyun.com/alpine/latest-stable/community" > /etc/apk/repositories
RUN apk update \
    && apk upgrade \
    && apk add tzdata \
    && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo Asia/Shanghai> /etc/timezone \
    && docker-php-ext-install mbstring opcache pdo pdo_mysql mysqli \
    && apk add --no-cache icu-dev gd-dev gettext-dev freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libmemcached libmemcached-libs zlib zlib-dev libmemcached-dev cyrus-sasl-dev libxml2-dev libxslt-dev openssl-dev libffi-dev zlib-dev \
    && docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-zlib-dir=/usr \
    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NPROC} gd zip \
    && docker-php-ext-install iconv \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install sockets \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-install xsl \
    && docker-php-ext-install intl \
    && docker-php-ext-install sysvsem \
    && docker-php-ext-install soap \
    && docker-php-ext-install gettext \
    && docker-php-ext-install shmop \
    && wget http://pecl.php.net/get/$REDIS_VER.tgz \
    && tar zxvf $REDIS_VER.tgz \
    && mkdir -p /usr/src/php/ext \
    && rm -rf $REDIS_VER.tgz \
    && rm -rf package.xml \
    && mv $REDIS_VER /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    && rm -rf /usr/src/php \
    && wget http://pecl.php.net/get/$MEMCACHED_VER.tgz \
    && tar zxvf $MEMCACHED_VER.tgz \
    && rm -rf $MEMCACHED_VER.tgz \
    && rm -rf package.xml \
    && mkdir -p /usr/src/php/ext \
    && mv $MEMCACHED_VER /usr/src/php/ext/memcached \
    && docker-php-ext-install memcached \
    && rm -rf /usr/src/php \
    && php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
    && chmod 755 composer-setup.php \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev
