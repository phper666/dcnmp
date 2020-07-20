#!/bin/sh

# 把需要安装软件到容器的命令写在这里

echo '--------------------start------------------------'

if [ "${ALPINE_REPOSITORIES_REPLACE}" = "true" ]; then
  sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories
fi

if [ "${TZ}" != "" ]; then
  echo "---------- Undate timezone ----------"
  cp "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" >/etc/timezone
fi

echo '--------------------end--------------------------'
