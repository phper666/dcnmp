ARG NEXUS3_VERSION=latest

#FROM maven:3-jdk-8-alpine AS build
#
#COPY ./nexus-repository-composer /nexus-repository-composer/
#RUN cd /nexus-repository-composer/; \
#    mvn clean package -PbuildKar;
#
#FROM sonatype/nexus3:${NEXUS3_VERSION}
#
#ARG DEPLOY_DIR=/opt/sonatype/nexus/deploy/
#USER root
#COPY --from=build /nexus-repository-composer/nexus-repository-composer/target/nexus-repository-composer-*-bundle.kar ${DEPLOY_DIR}
#USER nexus

FROM sonatype/nexus3:${NEXUS3_VERSION}

USER root
ARG NEXUS3_REPOSITORY_COMPOSER_VERSION=0.0.29
RUN echo ${NEXUS3_REPOSITORY_COMPOSER_VERSION}
RUN yum install -y wget
RUN cd /opt/sonatype/nexus/deploy && wget -O nexus-repository-composer-${NEXUS3_REPOSITORY_COMPOSER_VERSION}-bundle.kar https://search.maven.org/remotecontent?filepath=org/sonatype/nexus/plugins/nexus-repository-composer/${NEXUS3_REPOSITORY_COMPOSER_VERSION}/nexus-repository-composer-${NEXUS3_REPOSITORY_COMPOSER_VERSION}-bundle.kar
USER nexus

