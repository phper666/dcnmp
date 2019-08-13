ARG NODEJS_VERSION
FROM node:${NODEJS_VERSION}

ARG TZ
ARG ALPINE_REPOSITORIES

RUN sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories

# apk update && install
RUN apk update \
        && apk add --no-cache bash bash-doc bash-completion git python make openssl tar gcc tzdata \
        && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && echo "$TZ" > /etc/timezone
        && rm -rf /var/cache/apk/*

RUN npm install -g pm2

EXPOSE 3000

ENTRYPOINT ["node"]
