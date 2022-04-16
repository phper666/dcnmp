ARG NODEJS_VERSION
FROM node:${NODEJS_VERSION}

ARG TZ
ARG ALPINE_REPOSITORIES
ARG ALPINE_REPOSITORIES_REPLACE

RUN if [ "${ALPINE_REPOSITORIES_REPLACE}" = "true" ] ; then sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories ; else echo NO ; fi

# apk update && install
RUN set -ex \
        && apk update \
        && apk add --no-cache bash bash-doc bash-completion git python3 g++ make openssl tar tzdata \
        && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && echo "$TZ" > /etc/timezone \
        && rm -rf /var/cache/apk/*

#解决低镜像的权限问题
RUN npm config set unsafe-perm true

# https://www.jianshu.com/p/d636f96c9bf3
RUN npm install pm2 -g --registry=https://registry.npm.taobao.org

#安装yapi的cli命令
#RUN npm install -g yapi-cli --registry https://registry.npm.taobao.org

# 可以随便的切换npm的源工具，使用方法请看https://www.jianshu.com/p/4f9b09c428d1
#RUN npm install -g nrm

EXPOSE 3000

ENTRYPOINT ["node"]

WORKDIR /app/www
