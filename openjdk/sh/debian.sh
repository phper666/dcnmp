#!/bin/sh

# 把需要安装软件到容器的命令写在这里

echo '--------------------start------------------------'

if [ "${DEBIAN_REPOSITORIES_REPLACE}" = "true" ]; then
  echo "---------- php replace source ----------"
  mv /etc/apt/sources.list /etc/apt/sources.list.bak
  mv /var/local/source/sources.list /etc/apt/sources.list
  rm -rf /var/local/source
fi

if [ "${TZ}" != "" ]; then
  echo "---------- Undate timezone ----------"
  cp "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" >/etc/timezone
fi

echo '--------------------end--------------------------'
