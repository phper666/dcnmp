ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}

ARG ALPINE_REPOSITORIES

RUN sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories

# apk update && install bash
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash bash-doc bash-completion \
        && rm -rf /var/cache/apk/* \
        && /bin/bash
