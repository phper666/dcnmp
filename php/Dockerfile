ARG PHP_VERSION
FROM php:${PHP_VERSION}

ARG TZ
ARG PHP_EXTENSIONS
ARG PHP_MORE_EXTENSION_INSTALLER
ARG ALPINE_REPOSITORIES
ARG PHP_SWOOLE_VERSION
ARG PHP_SUPERVISORD_INSTALL

# Install composer
RUN cd /home
RUN curl -sS https://getcomposer.org/installer | php
#RUN wget https://getcomposer.org/composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer
#RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

COPY extensions /tmp/extensions
COPY sh /tmp/extensions
COPY soft /var/local/soft
WORKDIR /tmp/extensions

#使用$(nproc)在mac下会出现错误，现在还找不到解决方法，下面的数值是你的cpu核数，linux环境可以直接用
ENV MC="-j4"
ENV EXTENSIONS=",${PHP_EXTENSIONS},"

RUN chmod +x install.sh && chmod +x "${PHP_MORE_EXTENSION_INSTALLER}" && chmod +x supervisord.sh
RUN sh install.sh && sh "${PHP_MORE_EXTENSION_INSTALLER}" && sh supervisord.sh

RUN rm -rf /tmp/extensions

# 处理监控文件变化的软件
RUN mv /var/local/soft/swoolefor.phar /usr/local/bin/swoolefor
RUN chmod +x /usr/local/bin/swoolefor
RUN echo "alias swoolefor='php /usr/local/bin/swoolefor'" >> ~/.bashrc && source ~/.bashrc

# apk update && install
RUN apk update \
        && apk add --no-cache tzdata \
        && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && echo "$TZ" > /etc/timezone \
        && rm -rf /var/cache/apk/*

WORKDIR /app/www
