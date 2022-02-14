#!/bin/sh

echo
echo "============================================"
echo "Install PHP_EXTENSIONS from   : ${PHP_MORE_EXTENSION_INSTALLER}"
echo "PHP version                   : ${PHP_VERSION}"
echo "Extra PHP_EXTENSIONS          : ${PHP_EXTENSIONS}"
echo "Multicore Compilation         : ${MC}"
echo "Work directory                : ${PWD}"
echo "TZ                            : ${TZ}"
echo "PHP_INSTALL_EXTENSION_SCRIPT              : ${PHP_INSTALL_EXTENSION_SCRIPT}"
echo "PHP_SWOOLE_VERSION              : ${PHP_SWOOLE_VERSION}"
echo "============================================"
echo

if [ "${DEBIAN_REPOSITORIES_REPLACE}" = "true" ]; then
  echo "---------- php replace source ----------"
  mv /etc/apt/sources.list /etc/apt/sources.list.bak
  mv /var/local/source/sources.list /etc/apt/sources.list
  rm -rf /var/local/source
fi

echo "---------- Install general dependencies ----------"
apt-get update && apt-get upgrade && apt-get install -y git wget cmake apt-utils openssl libssl-dev zip unzip libc-dev zlib1g-dev libz-dev libpq-dev libcurl4-openssl-dev

usermod -u 1000 www-data && groupmod -g 1000 www-data

if [ "${PHP_INSTALL_SUPERVISOR}" = "true" ]; then
  echo "---------- Install Supervisor ----------"
  apt-get install -y supervisor
fi

if [ "${TZ}" != "" ]; then
  echo "---------- Undate timezone ----------"
  cp "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" >/etc/timezone
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_mysql,*}" ]; then
  echo "---------- Install pdo_mysql ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    # 默认还是使用这个命令安装，快速
    docker-php-ext-install ${MC} pdo_mysql
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions pdo_mysql
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,zip,*}" ]; then
  echo "---------- Install zip ----------"
  apt-get install -y libzip-dev
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} zip
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions zip
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,pcntl,*}" ]; then
  echo "---------- Install pcntl ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} pcntl
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions pcntl
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,mysqli,*}" ]; then
  echo "---------- Install mysqli ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} mysqli
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions mysqli
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,mbstring,*}" ]; then
  echo "---------- Install mbstring ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} mbstring
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions mbstring
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,exif,*}" ]; then
  echo "---------- Install exif ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} exif
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions exif
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,bcmath,*}" ]; then
  echo "---------- Install bcmath ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} bcmath
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions bcmath
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,calendar,*}" ]; then
  echo "---------- Install calendar ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} calendar
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions calendar
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,sockets,*}" ]; then
  echo "---------- Install sockets ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} sockets
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions sockets
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,gettext,*}" ]; then
  echo "---------- Install gettext ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} gettext
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions gettext
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,shmop,*}" ]; then
  echo "---------- Install shmop ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} shmop
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions shmop
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,sysvmsg,*}" ]; then
  echo "---------- Install sysvmsg ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} sysvmsg
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions sysvmsg
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,sysvsem,*}" ]; then
  echo "---------- Install sysvsem ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} sysvsem
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions sysvsem
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,sysvshm,*}" ]; then
  echo "---------- Install sysvshm ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} sysvshm
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions sysvshm
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_dblib,*}" ]; then
  echo "---------- Install pdo_dblib ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} pdo_dblib
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions pdo_dblib
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_oci,*}" ]; then
  echo "---------- Install pdo_oci ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} pdo_oci
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions pdo_oci
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_odbc,*}" ]; then
  echo "---------- Install pdo_odbc ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} pdo_odbc
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions pdo_odbc
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_pgsql,*}" ]; then
  echo "---------- Install pdo_pgsql ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} pdo_pgsql
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions pdo_pgsql
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,pgsql,*}" ]; then
  echo "---------- Install pgsql ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} pgsql
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions pgsql
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,oci8,*}" ]; then
  echo "---------- Install oci8 ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} oci8
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions oci8
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,odbc,*}" ]; then
  echo "---------- Install odbc ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} odbc
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions odbc
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,dba,*}" ]; then
  echo "---------- Install dba ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} dba
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions dba
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,gd,*}" ]; then
  echo "---------- Install gd ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev libjpeg-dev
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include
    docker-php-ext-install ${MC} gd
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions gd
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,intl,*}" ]; then
  echo "---------- Install intl ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libicu-dev
    docker-php-ext-install ${MC} intl
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions intl
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,bz2,*}" ]; then
  echo "---------- Install bz2 ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libbz2-dev
    docker-php-ext-install ${MC} bz2
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions bz2
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,soap,*}" ]; then
  echo "---------- Install soap ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev
    docker-php-ext-install ${MC} soap
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions soap
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,xsl,*}" ]; then
  echo "---------- Install xsl ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev
    docker-php-ext-install ${MC} xsl
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions xsl
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,xmlrpc,*}" ]; then
  echo "---------- Install xmlrpc ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev
    docker-php-ext-install ${MC} xmlrpc
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions xmlrpc
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

# 该扩展不支持7.4以上版本
if [ -z "${PHP_EXTENSIONS##*,wddx,*}" ]; then
  echo "---------- Install wddx ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev
    docker-php-ext-install ${MC} wddx
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions wddx
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,curl,*}" ]; then
  echo "---------- Install curl ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} curl
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions curl
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,readline,*}" ]; then
  echo "---------- Install readline ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get -y --no-install-recommends install libreadline-dev
    docker-php-ext-install ${MC} readline
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions readline
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,snmp,*}" ]; then
  echo "---------- Install snmp ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libsnmp-dev
    docker-php-ext-install ${MC} snmp
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions snmp
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,pspell,*}" ]; then
  echo "---------- Install pspell ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libpspell-dev
    docker-php-ext-install ${MC} pspell
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions pspell
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

# recode不支持7.4以上版本
if [ -z "${PHP_EXTENSIONS##*,recode,*}" ]; then
  echo "---------- Install recode ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends librecode-dev
    docker-php-ext-install ${MC} recode
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions recode
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,tidy,*}" ]; then
  echo "---------- Install tidy ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-de
    docker-php-ext-install ${MC} tidy
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions tidy
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,gmp,*}" ]; then
  echo "---------- Install gmp ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libgmp-dev
    docker-php-ext-install ${MC} gmp
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions gmp
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,imap,*}" ]; then
  echo "---------- Install imap ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libc-client-dev libkrb5-dev
    docker-php-ext-configure imap --with-imap --with-imap-ssl
    docker-php-ext-install ${MC} imap
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions imap
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,ldap,*}" ]; then
  echo "---------- Install ldap ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libldap2-dev
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu
    docker-php-ext-install ${MC} ldap
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions ldap
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,opcache,*}" ]; then
  echo "---------- Install opcache ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} opcache
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions opcache
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,sodium,*}" ]; then
  echo "---------- Install sodium ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    docker-php-ext-install ${MC} sodium
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions sodium
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,imagick,*}" ]; then
  echo "---------- Install imagick ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libmagickwand-dev
    printf "\n" | pecl install imagick
    docker-php-ext-enable imagick
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions imagick
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

# TODO php8.0暂不支持install-php-extensions安装sqlsrv
if [ -z "${PHP_EXTENSIONS##*,sqlsrv,*}" ]; then
  echo "---------- Install sqlsrv ----------"
  apt-get install -y apt-transport-https automake autotools-dev dirmngr gnupg gnupg-l10n gnupg-utils gpg gpg-agent gpg-wks-client gpg-wks-server gpgconf gpgsm libassuan0 libksba8 libltdl-dev libnpth0 pinentry-curses unixodbc-dev
  printf "\n" | pecl install sqlsrv
  docker-php-ext-enable sqlsrv
#  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
#
#  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
#    # 暂时无法安装，先使用beta版本
##    install-php-extensions sqlsrv
#  else
#    echo "only support pecl or install-php-extensions"
#  fi
fi

if [ -z "${PHP_EXTENSIONS##*,pdo_sqlsrv,*}" ]; then
  echo "---------- Install pdo_sqlsrv ----------"
  apt-get install -y apt-transport-https automake autotools-dev dirmngr gnupg gnupg-l10n gnupg-utils gpg gpg-agent gpg-wks-client gpg-wks-server gpgconf gpgsm libassuan0 libksba8 libltdl-dev libnpth0 pinentry-curses unixodbc-dev
  printf "\n" | pecl install pdo_sqlsrv
  docker-php-ext-enable pdo_sqlsrv
#  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
#
#  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
#    # 暂时无法安装，先使用beta版本
##    install-php-extensions pdo_sqlsrv
#  else
#    echo "only support pecl or install-php-extensions"
#  fi
fi

if [ -z "${PHP_EXTENSIONS##*,redis,*}" ]; then
  echo "---------- Install redis ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install redis
    docker-php-ext-enable redis
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions redis
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,memcached,*}" ]; then
  echo "---------- Install memcached ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends libmemcached-dev
    printf "\n" | pecl install memcached
    docker-php-ext-enable memcached
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions memcached
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,xdebug,*}" ]; then
  echo "---------- Install xdebug ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    pecl install xdebug
    docker-php-ext-enable xdebug
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions xdebug
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,swoole,*}" ]; then
  echo "---------- Install swoole ----------"
  # 或者使用pecl install -D
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get -y install libc-ares-dev
    apt-get -y install libcurl4-openssl-dev
    pecl install --configureoptions 'enable-sockets="no" enable-openssl="yes" enable-http2="yes" enable-mysqlnd="yes" enable-swoole-json="no" enable-swoole-curl="yes" enable-cares="yes"' ${PHP_SWOOLE_VERSION}
    docker-php-ext-enable swoole
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions ${PHP_SWOOLE_VERSION}
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,yaf,*}" ]; then
  echo "---------- Install yaf ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install yaf
    docker-php-ext-enable yaf
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions yaf
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,amqp,*}" ]; then
  # 当前php8只支持beta版本，目前作者的答复是beta虽然不是稳定发布版本，但是他们也在线上用
  echo "---------- Install amqp ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get install -y --no-install-recommends librabbitmq-dev
    printf "\n" | pecl install amqp-1.11.0beta
    docker-php-ext-enable amqp
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions amqp
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,mongodb,*}" ]; then
  echo "----- Install mongodb -----"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    pecl install mongodb
    docker-php-ext-enable mongodb
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions mongodb
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,event,*}" ]; then
  echo "---------- Install event ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    apt-get -y install libevent-dev
    printf "\n" | pecl install event
    docker-php-ext-enable --ini-name event.ini event
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions event
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,rar,*}" ]; then
  echo "---------- Install rar ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install rar
    docker-php-ext-enable rar
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions rar
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,ast,*}" ]; then
  echo "---------- Install ast ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install ast
    docker-php-ext-enable ast
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions ast
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,yac,*}" ]; then
  echo "---------- Install yac ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install yac
    docker-php-ext-enable yac
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions yac
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,yaconf,*}" ]; then
  echo "---------- Install yaconf ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install yaconf
    docker-php-ext-enable yaconf
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions yaconf
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,msgpack,*}" ]; then
  echo "---------- Install msgpack ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install msgpack
    docker-php-ext-enable msgpack
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions msgpack
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,igbinary,*}" ]; then
  echo "---------- Install igbinary ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install igbinary
    docker-php-ext-enable igbinary
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions igbinary
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,seaslog,*}" ]; then
  echo "---------- Install seaslog ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install seaslog
    docker-php-ext-enable seaslog
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions seaslog
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,varnish,*}" ]; then
  echo "---------- Install varnish ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install varnish
    docker-php-ext-enable varnish
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions varnish
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,xhprof,*}" ]; then
  echo "---------- Install xhprof ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install xhprof
    docker-php-ext-enable xhprof
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions xhprof
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,xlswriter,*}" ]; then
  echo "---------- Install xlswriter ----------"
  if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
    printf "\n" | pecl install xlswriter
    docker-php-ext-enable xlswriter
  elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
    install-php-extensions xlswriter
  else
    echo "only support pecl or install-php-extensions"
  fi
fi

if [ -z "${PHP_EXTENSIONS##*,rdkafka,*}" ]; then
    echo "---------- Install rdkafka ----------"
    if [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "pecl" ]; then
      cd "${EXTENSIONS_PATH}"
      tar -zxvf librdkafka-1.7.0.tar.gz
      mv librdkafka-1.7.0 /usr/local/src/librdkafka
      cd /usr/local/src/librdkafka && ./configure && make && make install

      printf "\n" | pecl install rdkafka
      docker-php-ext-enable rdkafka
    elif [ "${PHP_INSTALL_EXTENSION_SCRIPT}" = "install-php-extensions" ]; then
      install-php-extensions rdkafka
    else
      echo "only support pecl or install-php-extensions"
    fi
fi

echo "---------- clean cache ----------"
apt-get clean
