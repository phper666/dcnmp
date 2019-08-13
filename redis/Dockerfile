ARG REDIS_VERSION
FROM redis:${REDIS_VERSION}

ARG TZ
ARG ALPINE_REPOSITORIES

RUN sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories

# apk update && install bash
RUN apk update \
        && apk upgrade \
        && apk add --no-cache tzdata \
        && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && echo "$TZ" > /etc/timezone \
        && rm -rf /var/cache/apk/*



