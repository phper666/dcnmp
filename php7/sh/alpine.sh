#!/bin/sh

echo
echo "============================================"
echo "Install extensions from   : ${PHP_MORE_EXTENSION_INSTALLER}"
echo "PHP version               : ${PHP_VERSION}"
echo "Extra Extensions          : ${PHP_EXTENSIONS}"
echo "Multicore Compilation     : ${MC}"
echo "Work directory            : ${PWD}"
echo "time                      : ${TZ}"
echo "IMAGE_SYSTEM_TYPE         : ${IMAGE_SYSTEM_TYPE}"
echo "============================================"
echo

if [ "${ALPINE_REPOSITORIES_REPLACE}" = "true" ]; then
  sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories
fi

echo "---------- Apk update ----------"
apk update && apk add --no-cache git cmake tzdata gnu-libiconv shadow bzip2 && usermod -u 1000 www-data && groupmod -g 1000 www-data

# Fix: https://github.com/docker-library/php/issues/240
apk add --no-cache gnu-libiconv --repository http://${ALPINE_REPOSITORIES}/alpine/edge/community/ --allow-untrusted
export LD_PRELOAD="/usr/lib/preloadable_libiconv.so php"

if [ "${PHP_INSTALL_SUPERVISOR}" = "true" ]; then
  echo "---------- Install Supervisor ----------"
  apk add --no-cache supervisor
fi

if [ "${PHP_INSTALL_ALIYUN_OSS_SDK}" = "true" ]; then
  echo "---------- Install Aliyun Oss C++ Sdk ----------"
  apk add --no-cache cmake
  cd "${EXTENSIONS_PATH}"
  mkdir aliyun-oss-cpp-sdk
  tar -zxvf "${PHP_ALIYUN_OSS_SDK_VERSION}" -C aliyun-oss-cpp-sdk --strip-components=1
  cd aliyun-oss-cpp-sdk && makdir build
  cd build && cmake ..
  make && make install
fi

if [ "${TZ}" != "" ]; then
  echo "---------- Undate timezone ----------"
  cp "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" >/etc/timezone
fi

if [ "${PHP_EXTENSIONS}" != "" ]; then
  echo "---------- Install general dependencies ----------"
  apk add --no-cache autoconf g++ libtool make curl-dev libxml2-dev gettext-dev linux-headers
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_mysql,*}" ]; then
  echo "---------- Install pdo_mysql ----------"
  docker-php-ext-install ${MC} pdo_mysql
fi

if [ -z "${PHP_EXTENSIONS##*,zip,*}" ]; then
  echo "---------- Install zip ----------"
  apk add --no-cache libzip-dev
  docker-php-ext-install ${MC} zip
fi

if [ -z "${PHP_EXTENSIONS##*,pcntl,*}" ]; then
  echo "---------- Install pcntl ----------"
  docker-php-ext-install ${MC} pcntl
fi

if [ -z "${PHP_EXTENSIONS##*,mysqli,*}" ]; then
  echo "---------- Install mysqli ----------"
  docker-php-ext-install ${MC} mysqli
fi

if [ -z "${PHP_EXTENSIONS##*,mbstring,*}" ]; then
  echo "---------- Install mbstring ----------"
  docker-php-ext-install ${MC} mbstring
fi

if [ -z "${PHP_EXTENSIONS##*,exif,*}" ]; then
  echo "---------- Install exif ----------"
  docker-php-ext-install ${MC} exif
fi

if [ -z "${PHP_EXTENSIONS##*,bcmath,*}" ]; then
  echo "---------- Install bcmath ----------"
  docker-php-ext-install ${MC} bcmath
fi

if [ -z "${PHP_EXTENSIONS##*,calendar,*}" ]; then
  echo "---------- Install calendar ----------"
  docker-php-ext-install ${MC} calendar
fi

if [ -z "${PHP_EXTENSIONS##*,sockets,*}" ]; then
  echo "---------- Install sockets ----------"
  docker-php-ext-install ${MC} sockets
fi

if [ -z "${PHP_EXTENSIONS##*,gettext,*}" ]; then
  echo "---------- Install gettext ----------"
  docker-php-ext-install ${MC} gettext
fi

if [ -z "${PHP_EXTENSIONS##*,shmop,*}" ]; then
  echo "---------- Install shmop ----------"
  docker-php-ext-install ${MC} shmop
fi

if [ -z "${PHP_EXTENSIONS##*,sysvmsg,*}" ]; then
  echo "---------- Install sysvmsg ----------"
  docker-php-ext-install ${MC} sysvmsg
fi

if [ -z "${PHP_EXTENSIONS##*,sysvsem,*}" ]; then
  echo "---------- Install sysvsem ----------"
  docker-php-ext-install ${MC} sysvsem
fi

if [ -z "${PHP_EXTENSIONS##*,sysvshm,*}" ]; then
  echo "---------- Install sysvshm ----------"
  docker-php-ext-install ${MC} sysvshm
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_firebird,*}" ]; then
  echo "---------- Install pdo_firebird ----------"
  docker-php-ext-install ${MC} pdo_firebird
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_dblib,*}" ]; then
  echo "---------- Install pdo_dblib ----------"
  docker-php-ext-install ${MC} pdo_dblib
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_oci,*}" ]; then
  echo "---------- Install pdo_oci ----------"
  docker-php-ext-install ${MC} pdo_oci
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_odbc,*}" ]; then
  echo "---------- Install pdo_odbc ----------"
  docker-php-ext-install ${MC} pdo_odbc
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_pgsql,*}" ]; then
  echo "---------- Install pdo_pgsql ----------"
  apk --no-cache add postgresql-dev &&
    docker-php-ext-install ${MC} pdo_pgsql
fi

if [ -z "${PHP_EXTENSIONS##*,pgsql,*}" ]; then
  echo "---------- Install pgsql ----------"
  apk --no-cache add postgresql-dev &&
    docker-php-ext-install ${MC} pgsql
fi

if [ -z "${PHP_EXTENSIONS##*,oci8,*}" ]; then
  echo "---------- Install oci8 ----------"
  docker-php-ext-install ${MC} oci8
fi

if [ -z "${PHP_EXTENSIONS##*,odbc,*}" ]; then
  echo "---------- Install odbc ----------"
  docker-php-ext-install ${MC} odbc
fi

if [ -z "${PHP_EXTENSIONS##*,dba,*}" ]; then
  echo "---------- Install dba ----------"
  docker-php-ext-install ${MC} dba
fi

if [ -z "${PHP_EXTENSIONS##*,gd,*}" ]; then
  echo "---------- Install gd ----------"
  apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev
  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include
  docker-php-ext-install ${MC} gd
fi

if [ -z "${PHP_EXTENSIONS##*,intl,*}" ]; then
  echo "---------- Install intl ----------"
  apk add --no-cache icu-dev
  docker-php-ext-install ${MC} intl
fi

if [ -z "${PHP_EXTENSIONS##*,bz2,*}" ]; then
  echo "---------- Install bz2 ----------"
  apk add --no-cache bzip2-dev
  docker-php-ext-install ${MC} bz2
fi

if [ -z "${PHP_EXTENSIONS##*,soap,*}" ]; then
  echo "---------- Install soap ----------"
  docker-php-ext-install ${MC} soap
fi

if [ -z "${PHP_EXTENSIONS##*,xsl,*}" ]; then
  echo "---------- Install xsl ----------"
  apk add --no-cache libxslt-dev
  docker-php-ext-install ${MC} xsl
fi

if [ -z "${PHP_EXTENSIONS##*,xmlrpc,*}" ]; then
  echo "---------- Install xmlrpc ----------"
  apk add --no-cache libxslt-dev
  docker-php-ext-install ${MC} xmlrpc
fi

if [ -z "${PHP_EXTENSIONS##*,wddx,*}" ]; then
  echo "---------- Install wddx ----------"
  apk add --no-cache libxslt-dev
  docker-php-ext-install ${MC} wddx
fi

if [ -z "${PHP_EXTENSIONS##*,curl,*}" ]; then
  echo "---------- Install curl ----------"
  docker-php-ext-install ${MC} curl
fi

if [ -z "${PHP_EXTENSIONS##*,readline,*}" ]; then
  echo "---------- Install readline ----------"
  apk add --no-cache readline-dev
  apk add --no-cache libedit-dev
  docker-php-ext-install ${MC} readline
fi

if [ -z "${PHP_EXTENSIONS##*,snmp,*}" ]; then
  echo "---------- Install snmp ----------"
  apk add --no-cache net-snmp-dev
  docker-php-ext-install ${MC} snmp
fi

if [ -z "${PHP_EXTENSIONS##*,pspell,*}" ]; then
  echo "---------- Install pspell ----------"
  apk add --no-cache aspell-dev
  apk add --no-cache aspell-en
  docker-php-ext-install ${MC} pspell
fi

if [ -z "${PHP_EXTENSIONS##*,recode,*}" ]; then
  echo "---------- Install recode ----------"
  apk add --no-cache recode-dev
  docker-php-ext-install ${MC} recode
fi

if [ -z "${PHP_EXTENSIONS##*,tidy,*}" ]; then
  echo "---------- Install tidy ----------"
  apk add --no-cache tidyhtml-dev=5.2.0-r1 --repository http://${ALPINE_REPOSITORIES}/alpine/v3.6/community
  docker-php-ext-install ${MC} tidy
fi

if [ -z "${PHP_EXTENSIONS##*,gmp,*}" ]; then
  echo "---------- Install gmp ----------"
  apk add --no-cache gmp-dev
  docker-php-ext-install ${MC} gmp
fi

if [ -z "${PHP_EXTENSIONS##*,imap,*}" ]; then
  echo "---------- Install imap ----------"
  apk add --no-cache imap-dev
  docker-php-ext-configure imap --with-imap --with-imap-ssl
  docker-php-ext-install ${MC} imap
fi

if [ -z "${PHP_EXTENSIONS##*,ldap,*}" ]; then
  echo "---------- Install ldap ----------"
  apk add --no-cache ldb-dev
  apk add --no-cache openldap-dev
  docker-php-ext-install ${MC} ldap
fi

if [ -z "${PHP_EXTENSIONS##*,imagick,*}" ]; then
  echo "---------- Install imagick ----------"
  apk add --no-cache file-dev
  apk add --no-cache imagemagick-dev
  printf "\n" | pecl install imagick-3.4.4
  docker-php-ext-enable imagick
fi

if [[ -z "${PHP_EXTENSIONS##*,sqlsrv,*}" ]]; then
  echo "---------- Install sqlsrv ----------"
  apk add --no-cache unixodbc-dev
  printf "\n" | pecl install sqlsrv
  docker-php-ext-enable sqlsrv
fi

if [[ -z "${PHP_EXTENSIONS##*,pdo_sqlsrv,*}" ]]; then
  echo "---------- Install pdo_sqlsrv ----------"
  apk add --no-cache unixodbc-dev
  printf "\n" | pecl install pdo_sqlsrv
  docker-php-ext-enable pdo_sqlsrv
fi

if [ -z "${PHP_EXTENSIONS##*,opcache,*}" ]; then
  echo "---------- Install opcache ----------"
  docker-php-ext-install opcache
fi

if [ -z "${PHP_EXTENSIONS##*,redis,*}" ]; then
  echo "---------- Install redis ----------"
  cd "${EXTENSIONS_PATH}"
  mkdir redis
  tar -xf redis-5.0.2.tgz -C redis --strip-components=1
  cd redis && phpize && ./configure && make ${MC} && make install
  docker-php-ext-enable redis
fi

if [ -z "${PHP_EXTENSIONS##*,memcached,*}" ]; then
  echo "---------- Install memcached ----------"
  apk add --no-cache libmemcached-dev zlib-dev
  printf "\n" | pecl install memcached-3.1.3
  docker-php-ext-enable memcached
fi

if [ -z "${PHP_EXTENSIONS##*,xdebug,*}" ]; then
  echo "---------- Install xdebug ----------"
  cd "${EXTENSIONS_PATH}"
  mkdir xdebug
  tar -xf xdebug-2.6.1.tgz -C xdebug --strip-components=1
  cd xdebug && phpize && ./configure && make ${MC} && make install
  docker-php-ext-enable xdebug
fi

if [ -z "${PHP_EXTENSIONS##*,swoole,*}" ]; then
  echo "---------- Install swoole(${PHP_SWOOLE_VERSION})----------"
  cd "${EXTENSIONS_PATH}"
  mkdir swoole
  tar -zxvf "${PHP_SWOOLE_VERSION}" -C swoole --strip-components=1
  cd swoole && phpize && ./configure --enable-openssl && make ${MC} && make install
  docker-php-ext-enable swoole
fi

if [[ -z "${PHP_EXTENSIONS##*,sodium,*}" ]]; then
  echo "---------- Install sodium ----------"
  apk add --no-cache libsodium-dev
  docker-php-ext-install ${MC} sodium
fi

if [ -z "${PHP_EXTENSIONS##*,yaf,*}" ]; then
  echo "---------- Install yaf ----------"
  printf "\n" | pecl install yaf
  docker-php-ext-enable yaf
fi

if [ -z "${PHP_EXTENSIONS##*,amqp,*}" ]; then
  echo "---------- Install amqp ----------"
  apk add --no-cache rabbitmq-c-dev
  pecl install amqp 1.9.4
  docker-php-ext-enable amqp
fi

if [ -z "${PHP_EXTENSIONS##*,mongodb,*}" ]; then
  echo "---------- Install mongodb ----------"
  pecl install mongodb
  docker-php-ext-enable mongodb
fi

if [ -z "${PHP_EXTENSIONS##*,event,*}" ]; then
  echo "---------- Install event ----------"
  apk add --no-cache libevent-dev
  cd "${EXTENSIONS_PATH}"
  mkdir event
  tar -xf event-2.5.3.tgz -C event --strip-components=1
  cd event && phpize && ./configure && make ${MC} && make install
  docker-php-ext-enable --ini-name event.ini
fi

if [[ -z "${PHP_EXTENSIONS##*,rar,*}" ]]; then
  echo "---------- Install rar ----------"
  printf "\n" | pecl install rar
  docker-php-ext-enable rar
fi

if [[ -z "${PHP_EXTENSIONS##*,ast,*}" ]]; then
  echo "---------- Install ast ----------"
  printf "\n" | pecl install ast
  docker-php-ext-enable ast
fi

if [[ -z "${PHP_EXTENSIONS##*,yac,*}" ]]; then
  echo "---------- Install yac ----------"
  printf "\n" | pecl install yac-2.0.2
  docker-php-ext-enable yac
fi

if [[ -z "${PHP_EXTENSIONS##*,yaconf,*}" ]]; then
  echo "---------- Install yaconf ----------"
  printf "\n" | pecl install yaconf
  docker-php-ext-enable yaconf
fi

if [[ -z "${PHP_EXTENSIONS##*,msgpack,*}" ]]; then
  echo "---------- Install msgpack ----------"
  printf "\n" | pecl install msgpack
  docker-php-ext-enable msgpack
fi

if [[ -z "${PHP_EXTENSIONS##*,igbinary,*}" ]]; then
  echo "---------- Install igbinary ----------"
  printf "\n" | pecl install igbinary
  docker-php-ext-enable igbinary
fi

if [[ -z "${PHP_EXTENSIONS##*,seaslog,*}" ]]; then
  echo "---------- Install seaslog ----------"
  printf "\n" | pecl install seaslog
  docker-php-ext-enable seaslog
fi

if [[ -z "${PHP_EXTENSIONS##*,varnish,*}" ]]; then
  echo "---------- Install varnish ----------"
  apk add --no-cache varnish-dev
  printf "\n" | pecl install varnish
  docker-php-ext-enable varnish
fi

if [[ -z "${PHP_EXTENSIONS##*,xhprof,*}" ]]; then
  echo "---------- Install XHProf ----------"
  cd "${EXTENSIONS_PATH}"
  mkdir xhprof
  tar -xf xhprof-2.1.0.tgz -C xhprof --strip-components=1
  cd xhprof/extension/ && phpize && ./configure && make ${MC} && make install
  docker-php-ext-enable xhprof
fi

if [[ -z "${PHP_EXTENSIONS##*,xlswriter,*}" ]]; then
  echo "---------- Install xlswriter ----------"
  printf "\n" | pecl install xlswriter
  docker-php-ext-enable xlswriter
fi

if [ -z "${PHP_EXTENSIONS##*,rdkafka,*}" ]; then
    echo "---------- Install rdkafka ----------"
    cd "${EXTENSIONS_PATH}"
    tar -zxvf librdkafka-1.5.0.tar.gz
    mv librdkafka-1.5.0 /usr/local/src/librdkafka
    cd /usr/local/src/librdkafka && ./configure && make && make install

    printf "\n" | pecl install rdkafka
    docker-php-ext-enable rdkafka
fi

echo "---------- Apk cache delete ----------"
rm -rf /var/cache/apk/*
