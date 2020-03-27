ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}

ARG TZ
ARG ALPINE_REPOSITORIES
ARG ALPINE_REPOSITORIES_REPLACE

RUN if [ "${ALPINE_REPOSITORIES_REPLACE}" = "true" ] ; then sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories ; else echo NO ; fi

# apk update && install bash
RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && apk add --no-cache bash bash-doc bash-completion tzdata curl \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone \
    && rm -rf /var/cache/apk/*

RUN set -x ; \
    addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1
