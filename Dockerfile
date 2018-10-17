FROM daocloud.io/library/php:7.2.9-fpm-alpine
RUN echo -e "http://mirrors.aliyun.com/alpine/latest-stable/main\nhttp://mirrors.aliyun.com/alpine/latest-stable/community" > /etc/apk/repositories
RUN apk update \
    && apk upgrade \
    && apk add tzdata \
    && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo Asia/Shanghai> /etc/timezone \
    && docker-php-ext-install mbstring opcache pdo pdo_mysql mysqli \
    && apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
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
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com
    #&& docker-php-ext-enable gd \
    #&& docker-php-ext-enable zip \ 
    #&& apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev
