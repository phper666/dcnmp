ARG NODEJS_VERSION
FROM node:${NODEJS_VERSION}

#解决低镜像的权限问题
RUN npm config set unsafe-perm true

# https://www.jianshu.com/p/d636f96c9bf3
RUN npm install pm2 -g

# 可以随便的切换npm的源工具，使用方法请看https://www.jianshu.com/p/4f9b09c428d1
#RUN npm install -g nrm

EXPOSE 3000

ENTRYPOINT ["node"]
