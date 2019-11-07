ARG PHP_VERSION
FROM php:${PHP_VERSION}

ARG TZ
ARG PHP_EXTENSIONS
ARG PHP_MORE_EXTENSION_INSTALLER
ARG ALPINE_REPOSITORIES
ARG PHP_SWOOLE_VERSION

RUN sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories

# Fix: https://github.com/docker-library/php/issues/240
RUN apk add gnu-libiconv --no-cache --repository http://${ALPINE_REPOSITORIES}/alpine/edge/community/ --allow-untrusted
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN cd /home

# Install composer
RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer
#RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

COPY extensions /tmp/extensions
COPY sh /tmp/extensions
COPY soft /var/local/soft
WORKDIR /tmp/extensions

#使用$(nproc)在mac下会出现错误，现在还找不到解决方法，下面的数值是你的cpu核数，linux环境可以直接用
ENV MC="-j4"
ENV EXTENSIONS=",${PHP_EXTENSIONS},"

RUN chmod +x install.sh && chmod +x "${PHP_MORE_EXTENSION_INSTALLER}"
RUN sh install.sh && sh "${PHP_MORE_EXTENSION_INSTALLER}"

RUN rm -rf /tmp/extensions

# 处理监控文件变化的软件
RUN mv /var/local/soft/swoolefor.phar /usr/local/bin/swoolefor
RUN chmod +x /usr/local/bin/swoolefor
RUN echo "alias swoolefor='php /usr/local/bin/swoolefor'" >> ~/.bashrc && source ~/.bashrc

# 移动composer
#RUN mv /var/local/soft/composer.phar /usr/local/bin/composer
#RUN chmod +x /usr/local/bin/composer

# apk update && install
RUN apk update \
        && apk add --no-cache tzdata \
        && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && echo "$TZ" > /etc/timezone \
        && rm -rf /var/cache/apk/*

WORKDIR /app/www
