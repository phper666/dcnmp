ARG PHP_VERSION
FROM php:${PHP_VERSION}

ARG PHP_EXTENSIONS
ARG MORE_EXTENSION_INSTALLER
ARG ALPINE_REPOSITORIES
ARG SWOOLE_VERSION
ARG SUPERVIOSORD_INSTALL

# Install composer
RUN cd /home
RUN curl -sS https://getcomposer.org/installer | php
#RUN wget https://getcomposer.org/composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer
#RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

COPY extensions /tmp/extensions
COPY sh/install.sh /tmp/extensions/install.sh
COPY sh/php56.sh /tmp/extensions/php56.sh
COPY sh/php72.sh /tmp/extensions/php72.sh
COPY sh/supervisord.sh /tmp/extensions/supervisord.sh
WORKDIR /tmp/extensions

#使用$(nproc)会出现错误，现在还找不到解决方法，下面的数值是你的cpu核数
ENV MC="-j4"
ENV EXTENSIONS=",${PHP_EXTENSIONS},"
ENV SUPERVIOSORD_INSTALL="${SUPERVIOSORD_INSTALL}"

RUN chmod +x install.sh && chmod +x "${MORE_EXTENSION_INSTALLER}" && chmod +x supervisord.sh
RUN sh install.sh && sh "${MORE_EXTENSION_INSTALLER}" && sh supervisord.sh

RUN rm -rf /tmp/extensions

WORKDIR /var/www/html
