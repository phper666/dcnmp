ARG NODEJS_VERSION
FROM node:${NODEJS_VERSION}

ARG ALPINE_REPOSITORIES

RUN sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories

# apk update && install bash
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash bash-doc bash-completion git python make openssl tar gcc \
        && rm -rf /var/cache/apk/* \
        && /bin/bash

RUN npm install -g pm2

ENV TZ="Asia/Shanghai"

EXPOSE 3000

ENTRYPOINT ["node"]
