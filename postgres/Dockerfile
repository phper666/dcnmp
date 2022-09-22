ARG POSTGRES_VERSION=alpine
FROM postgres:${POSTGRES_VERSION}

ADD ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

# 初始化一些数据库
RUN chmod -R +x /docker-entrypoint-initdb.d

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
