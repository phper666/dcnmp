#!/bin/sh
DOCKER_COMPOSE_VERSION="1.25.4"

echo "Install Docker Start"

# yum更新包
yum -y update

# 卸载旧的docker
yum -y remove docker docker-common docker-selinux docker-engine

# 安装基础的工具yum-utils device-mapper-persistent-data lvm2
yum -y install yum-utils device-mapper-persistent-data lvm2

# 添加docker-ce yum仓库
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 安装docker-ce
yum -y install docker-ce

# 启动、停止docker服务
systemctl stop docker
systemctl start docker
# 关闭docker服务
# systemctl stop docker

# 开机自启动docker
systemctl enable docker

echo "Docker Version"
docker version

echo "Install Dcoker-compose"
echo '{ "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn", "https://6kx4zyno.mirror.aliyuncs.com", "https://registry.docker-cn.com"] }' > /etc/docker/daemon.conf

# 获取docker-compose文件
# curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# 国内加速
curl -L https://get.daocloud.io/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

# 给权限
chmod +x /usr/local/bin/docker-compose

echo "Docker-compose Version"
# 如果命令不存在，则需要添加环境变量，在~/.bash_profile或者~/.profile里面的PATH加入/usr/local/bin
docker-compose version
