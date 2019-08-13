ARG RABBITMQ_VERSION
FROM rabbitmq:${RABBITMQ_VERSION}

ARG TZ

# apk update && install
RUN apk update \
        && apk upgrade \
        && apk add --no-cache tzdata \
        && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && echo "$TZ" > /etc/timezone \
        && rm -rf /var/cache/apk/*
