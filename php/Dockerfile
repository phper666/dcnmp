ARG PHP_VERSION
FROM php:${PHP_VERSION}

ARG PHP_EXTENSIONS
ARG PHP_MORE_EXTENSION_INSTALLER
ARG PHP_ALPINE_REPOSITORIES
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
#COPY sh/install.sh /tmp/extensions/install.sh
#COPY sh/php56.sh /tmp/extensions/php56.sh
#COPY sh/php72.sh /tmp/extensions/php72.sh
#COPY sh/supervisord.sh /tmp/extensions/supervisord.sh
WORKDIR /tmp/extensions

#使用$(nproc)会出现错误，现在还找不到解决方法，下面的数值是你的cpu核数
ENV MC="-j4"
ENV EXTENSIONS=",${PHP_EXTENSIONS},"

RUN chmod +x install.sh && chmod +x "${PHP_MORE_EXTENSION_INSTALLER}" && chmod +x supervisord.sh
RUN sh install.sh && sh "${PHP_MORE_EXTENSION_INSTALLER}" && sh supervisord.sh

RUN rm -rf /tmp/extensions

WORKDIR /var/www/html
