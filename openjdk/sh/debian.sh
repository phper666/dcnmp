#!/bin/sh

# 把需要安装软件到容器的命令写在这里

echo '--------------------start------------------------'

if [ "${DEBIAN_REPOSITORIES_REPLACE}" = "true" ]; then
  echo "---------- php replace source ----------"
  cp /etc/apt/sources.list /etc/apt/sources.list.bak
  sed -i "s/deb.debian.org/${DEBIAN_REPOSITORIES}/" /etc/apt/sources.list
  sed -i "s/security.debian.org/${DEBIAN_REPOSITORIES}/" /etc/apt/sources.list
  sed -i "s/security-cdn.debian.org/${DEBIAN_REPOSITORIES}/" /etc/apt/sources.list
fi

if [ "${TZ}" != "" ]; then
  echo "---------- Undate timezone ----------"
  cp "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" >/etc/timezone
fi

if [ "${MAVEN_VERSION}" != "" ]; then
  echo "---------- Install MAVEN ${MAVEN_VERSION}----------"
  cd /tmp/extensions && wget https://mirrors.cnnic.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz --no-check-certificate
  tar -zxvf /tmp/extensions/${MAVEN_VERSION}
  mv apache-maven-3.6.3 /usr/local/maven
  ln -s /usr/local/maven/bin/mvn  /usr/bin/mvn
  echo 'export MAVEN_HOME=/usr/local/maven' >> ~/.profile
  echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.profile
fi

echo '--------------------end--------------------------'
