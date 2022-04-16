ARG PHP_VERSION
FROM php:${PHP_VERSION}

ARG TZ
ARG ALPINE_REPOSITORIES
ARG ALPINE_REPOSITORIES_REPLACE
ARG DEBIAN_REPOSITORIES_REPLACE
ARG DEBIAN_REPOSITORIES
ARG PHP_EXTENSIONS
ARG PHP_MORE_EXTENSION_INSTALLER
ARG PHP_REPLACE_SOURCE
ARG PHP_INSTALL_SUPERVISOR
ARG PHP_INSTALL_EXTENSION_SCRIPT
ARG PHP_SWOOLE_VERSION

RUN cd /home

# Install composer
RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer
#RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

COPY extensions /tmp/extensions
COPY sh /tmp/extensions
COPY soft /var/local/soft
COPY source /var/local/source
WORKDIR /tmp/extensions

# 安装install-php-extensions脚本，github地址:https://github.com/mlocati/docker-php-extension-installer
ADD ./extensions/install-php-extensions  /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions

#使用$(nproc)在mac下会出现错误，现在还找不到解决方法，下面的数值是你的cpu核数，linux环境可以直接用
ENV MC="-j2"
ENV PHP_EXTENSIONS=",${PHP_EXTENSIONS},"
ENV EXTENSIONS_PATH="/tmp/extensions"

# 安装扩展
RUN chmod -R 777 /tmp/extensions
RUN sh "${PHP_MORE_EXTENSION_INSTALLER}"

RUN rm -rf /tmp/extensions

WORKDIR /app/www
