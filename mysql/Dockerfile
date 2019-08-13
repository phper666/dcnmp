ARG MYSQL_VERSION
FROM mysql:${MYSQL_VERSION}

ARG TZ

RUN chmod 777 -R /var/log/

# apk update && install
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash bash-doc bash-completion tzdata \
        && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && echo "$TZ" > /etc/timezone \
        && rm -rf /var/cache/apk/*
