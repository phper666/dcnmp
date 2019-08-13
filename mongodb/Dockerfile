ARG MONGODB_VERSION
FROM mongo:${MONGODB_VERSION}

ARG TZ

# apk update && install
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash bash-doc bash-completion tzdata \
        && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && echo "$TZ" > /etc/timezone \
        && rm -rf /var/cache/apk/*
