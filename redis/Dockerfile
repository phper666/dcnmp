ARG REDIS_VERSION
FROM redis:${REDIS_VERSION}

ARG TZ
ARG ALPINE_REPOSITORIES
ARG ALPINE_REPOSITORIES_REPLACE

RUN if [ "${ALPINE_REPOSITORIES_REPLACE}" = "true" ] ; then sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories ; else echo NO ; fi

# apk update && install bash
RUN apk update \
        && apk add --no-cache openssl tzdata bash bash-doc bash-completion tzdata curl \
        && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && echo "$TZ" > /etc/timezone \
        && rm -rf /var/cache/apk/*



