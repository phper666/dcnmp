#!/bin/sh

echo
echo "============================================"
echo "Install PHP_EXTENSIONS from   : ${PHP_MORE_EXTENSION_INSTALLER}"
echo "PHP version                   : ${PHP_VERSION}"
echo "Extra PHP_EXTENSIONS          : ${PHP_EXTENSIONS}"
echo "Multicore Compilation         : ${MC}"
echo "Work directory                : ${PWD}"
echo "TZ                            : ${TZ}"
echo "============================================"
echo

if [ "${DEBIAN_REPOSITORIES_REPLACE}" = "true" ]; then
  echo "---------- php replace source ----------"
  mv /etc/apt/sources.list /etc/apt/sources.list.bak
  mv /var/local/source/sources.list /etc/apt/sources.list
  rm -rf /var/local/source
fi

echo "---------- Install general dependencies ----------"
apt-get update && apt-get upgrade && apt-get install -y git cmake apt-utils openssl libssl-dev zip unzip libc-dev zlib1g-dev libz-dev libpq-dev libcurl4-openssl-dev

usermod -u 1000 www-data && groupmod -g 1000 www-data

if [ "${PHP_INSTALL_SUPERVISOR}" = "true" ]; then
  echo "---------- Install Supervisor ----------"
  apt-get install -y supervisor
fi

if [ "${PHP_INSTALL_ALIYUN_OSS_SDK}" = "true" ]; then
  echo "---------- Install Aliyun Oss C++ Sdk ----------"
  apt-get install -y cmake libcurl4-openssl-dev libapr1-dev libaprutil1-dev libmxml-dev
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

if [ -z "${PHP_EXTENSIONS##*,pdo_mysql,*}" ]; then
  echo "---------- Install pdo_mysql ----------"
  docker-php-ext-install ${MC} pdo_mysql
fi

if [ -z "${PHP_EXTENSIONS##*,zip,*}" ]; then
  echo "---------- Install zip ----------"
  apt-get install -y libzip-dev
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
  docker-php-ext-install ${MC} pdo_pgsql
fi

if [ -z "${PHP_EXTENSIONS##*,pgsql,*}" ]; then
  echo "---------- Install pgsql ----------"
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
  apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev libjpeg-dev
  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include
  docker-php-ext-install ${MC} gd
fi

if [ -z "${PHP_EXTENSIONS##*,intl,*}" ]; then
  echo "---------- Install intl ----------"
  apt-get install -y --no-install-recommends libicu-dev
  docker-php-ext-install ${MC} intl
fi

if [ -z "${PHP_EXTENSIONS##*,bz2,*}" ]; then
  echo "---------- Install bz2 ----------"
  apt-get install -y --no-install-recommends libbz2-dev
  docker-php-ext-install ${MC} bz2
fi

if [ -z "${PHP_EXTENSIONS##*,soap,*}" ]; then
  echo "---------- Install soap ----------"
  apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev
  docker-php-ext-install ${MC} soap
fi

if [ -z "${PHP_EXTENSIONS##*,xsl,*}" ]; then
  echo "---------- Install xsl ----------"
  apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev
  docker-php-ext-install ${MC} xsl
fi

if [ -z "${PHP_EXTENSIONS##*,xmlrpc,*}" ]; then
  echo "---------- Install xmlrpc ----------"
  apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev
  docker-php-ext-install ${MC} xmlrpc
fi

if [ -z "${PHP_EXTENSIONS##*,wddx,*}" ]; then
  echo "---------- Install wddx ----------"
  apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev
  docker-php-ext-install ${MC} wddx
fi

if [ -z "${PHP_EXTENSIONS##*,curl,*}" ]; then
  echo "---------- Install curl ----------"
  docker-php-ext-install ${MC} curl
fi

if [ -z "${PHP_EXTENSIONS##*,readline,*}" ]; then
  echo "---------- Install readline ----------"
  apt-get -y --no-install-recommends install libreadline-dev
  docker-php-ext-install ${MC} readline
fi

if [ -z "${PHP_EXTENSIONS##*,snmp,*}" ]; then
  echo "---------- Install snmp ----------"
  apt-get install -y --no-install-recommends libsnmp-dev
  docker-php-ext-install ${MC} snmp
fi

if [ -z "${PHP_EXTENSIONS##*,pspell,*}" ]; then
  echo "---------- Install pspell ----------"
  apt-get install -y --no-install-recommends libpspell-dev
  docker-php-ext-install ${MC} pspell
fi

if [ -z "${PHP_EXTENSIONS##*,recode,*}" ]; then
  echo "---------- Install recode ----------"
  apt-get install -y --no-install-recommends librecode-dev
  docker-php-ext-install ${MC} recode
fi

if [ -z "${PHP_EXTENSIONS##*,tidy,*}" ]; then
  echo "---------- Install tidy ----------"
  apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-de
  docker-php-ext-install ${MC} tidy
fi

if [ -z "${PHP_EXTENSIONS##*,gmp,*}" ]; then
  echo "---------- Install gmp ----------"
  apt-get install -y --no-install-recommends libgmp-dev
  docker-php-ext-install ${MC} gmp
fi

if [ -z "${PHP_EXTENSIONS##*,imap,*}" ]; then
  echo "---------- Install imap ----------"
  apt-get install -y --no-install-recommends libc-client-dev libkrb5-dev
  docker-php-ext-configure imap --with-imap --with-imap-ssl
  docker-php-ext-install ${MC} imap
fi

if [ -z "${PHP_EXTENSIONS##*,ldap,*}" ]; then
  echo "---------- Install ldap ----------"
  apt-get install -y --no-install-recommends libldap2-dev
  docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu
  docker-php-ext-install ${MC} ldap
fi

if [ -z "${PHP_EXTENSIONS##*,imagick,*}" ]; then
  echo "---------- Install imagick ----------"
  apt-get install -y --no-install-recommends libmagickwand-dev
  printf "\n" | pecl install imagick-3.4.4
  docker-php-ext-enable imagick
fi

if [ -z "${PHP_EXTENSIONS##*,sqlsrv,*}" ]; then
  echo "---------- Install sqlsrv ----------"
  apt-get install msodbcsql mssql-tools unixodbc-dev
  printf "\n" | pecl install sqlsrv
  docker-php-ext-enable sqlsrv
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_sqlsrv,*}" ]; then
  echo "---------- Install pdo_sqlsrv ----------"
  apt-get install msodbcsql mssql-tools unixodbc-dev
  printf "\n" | pecl install sqlsrv
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
  tar -zxvf redis-5.0.2.tgz -C redis --strip-components=1
  cd redis && phpize && ./configure && make ${MC} && make install
  docker-php-ext-enable redis
fi

if [ -z "${PHP_EXTENSIONS##*,memcached,*}" ]; then
  echo "---------- Install memcached ----------"
  apt-get install -y --no-install-recommends libmemcached-dev
  printf "\n" | pecl install memcached-3.1.3
  docker-php-ext-enable memcached
fi

if [ -z "${PHP_EXTENSIONS##*,xdebug,*}" ]; then
  echo "---------- Install xdebug ----------"
  cd "${EXTENSIONS_PATH}"
  mkdir xdebug
  tar -zxvf xdebug-2.6.1.tgz -C xdebug --strip-components=1
  cd xdebug && phpize && ./configure && make ${MC} && make install
  docker-php-ext-enable xdebug
fi

if [ -z "${PHP_EXTENSIONS##*,swoole,*}" ]; then
  echo "---------- Install swoole(${PHP_SWOOLE_VERSION})----------"
  apt-get install -y openssl libssl-dev
  cd "${EXTENSIONS_PATH}"
  mkdir swoole
  tar -zxvf "${PHP_SWOOLE_VERSION}" -C swoole --strip-components=1
  cd swoole && phpize && ./configure --enable-openssl && make ${MC} && make install
  docker-php-ext-enable swoole
fi

if [ -z "${PHP_EXTENSIONS##*,sodium,*}" ]; then
  echo "---------- Install sodium ----------"
  docker-php-ext-install ${MC} sodium
fi

if [ -z "${PHP_EXTENSIONS##*,yaf,*}" ]; then
  echo "---------- Install yaf ----------"
  printf "\n" | pecl install yaf
  docker-php-ext-enable yaf
fi

if [ -z "${PHP_EXTENSIONS##*,amqp,*}" ]; then
  echo "---------- Install amqp ----------"
  apt-get install -y --no-install-recommends librabbitmq-dev
  pecl install amqp 1.9.4
  docker-php-ext-enable amqp
fi

if [ -z "${PHP_EXTENSIONS##*,mongodb,*}" ]; then
  echo "---------- Install mongodb ----------"
  cd "${EXTENSIONS_PATH}"
  mkdir mongodb
  tar -zxvf mongodb-1.7.4.tgz -C mongodb --strip-components=1
  cd mongodb && phpize && ./configure --with-php-config=/usr/local/bin/php-config && make ${MC} && make install
  docker-php-ext-enable mongodb
fi

if [ -z "${PHP_EXTENSIONS##*,event,*}" ]; then
  echo "---------- Install event ----------"
  apt-get -y install libevent-dev
  cd "${EXTENSIONS_PATH}"
  mkdir event
  tar -zxvf event-2.5.3.tgz -C event --strip-components=1
  cd event && phpize && ./configure --with-php-config=/usr/local/bin/php-config && make ${MC} && make install
  docker-php-ext-enable --ini-name event.ini event
fi

if [ -z "${PHP_EXTENSIONS##*,rar,*}" ]; then
  echo "---------- Install rar ----------"
  printf "\n" | pecl install rar
  docker-php-ext-enable rar
fi

if [ -z "${PHP_EXTENSIONS##*,ast,*}" ]; then
  echo "---------- Install ast ----------"
  printf "\n" | pecl install ast
  docker-php-ext-enable ast
fi

if [ -z "${PHP_EXTENSIONS##*,yac,*}" ]; then
  echo "---------- Install yac ----------"
  printf "\n" | pecl install yac-2.0.2
  docker-php-ext-enable yac
fi

if [ -z "${PHP_EXTENSIONS##*,yaconf,*}" ]; then
  echo "---------- Install yaconf ----------"
  printf "\n" | pecl install yaconf
  docker-php-ext-enable yaconf
fi

if [ -z "${PHP_EXTENSIONS##*,msgpack,*}" ]; then
  echo "---------- Install msgpack ----------"
  printf "\n" | pecl install msgpack
  docker-php-ext-enable msgpack
fi

if [ -z "${PHP_EXTENSIONS##*,igbinary,*}" ]; then
  echo "---------- Install igbinary ----------"
  printf "\n" | pecl install igbinary
  docker-php-ext-enable igbinary
fi

if [ -z "${PHP_EXTENSIONS##*,seaslog,*}" ]; then
  echo "---------- Install seaslog ----------"
  printf "\n" | pecl install seaslog
  docker-php-ext-enable seaslog
fi

if [ -z "${PHP_EXTENSIONS##*,varnish,*}" ]; then
  echo "---------- Install varnish ----------"
  printf "\n" | pecl install varnish
  docker-php-ext-enable varnish
fi

if [ -z "${PHP_EXTENSIONS##*,xhprof,*}" ]; then
  echo "---------- Install XHProf ----------"
  cd "${EXTENSIONS_PATH}"
  mkdir xhprof
  tar -zxvf xhprof-2.1.0.tgz -C xhprof --strip-components=1
  cd xhprof/extension && phpize && ./configure && make ${MC} && make install
  docker-php-ext-enable xhprof
fi

if [ -z "${PHP_EXTENSIONS##*,xlswriter,*}" ]; then
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

echo "---------- clean cache ----------"
apt-get clean
