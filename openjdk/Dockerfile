ARG OPENJDK_VERSION
FROM openjdk:${OPENJDK_VERSION}

ARG TZ
ARG ALPINE_REPOSITORIES
ARG ALPINE_REPOSITORIES_REPLACE
ARG DEBIAN_REPOSITORIES_REPLACE
ARG OPENJDK_MORE_INSTALLER
ARG MAVEN_VERSION

RUN cd /home

#COPY extensions /tmp/extensions
COPY sh /tmp/extensions
COPY source /var/local/source

# 安装软件
RUN chmod -R 777 /tmp/extensions
RUN sh /tmp/extensions/${OPENJDK_MORE_INSTALLER}

RUN rm -rf /tmp/extensions
WORKDIR /app/webapps
