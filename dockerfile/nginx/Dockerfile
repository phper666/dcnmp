ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}

# apk update && install bash
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash bash-doc bash-completion \
        && rm -rf /var/cache/apk/* \
        && /bin/bash
