集成了多个服务，目前有nginx、php72、php56、mysql、mongodb、redis、rabbitmq、phpredisadmin、supervisord(安装在php容器中，如不需要，请到)。请查看docker-compose-sample.yml文件，如果不需要那么多服务注释掉相应的服务即可。这些服务的配置都在.env.sample文件中，请认真查看

# 目录
- [1.目录结构](#1目录结构)
- [2.使用](#2使用)
- [3.PHP和扩展](#3PHP和扩展)
    - [3.1 切换Nginx使用的PHP版本](#31-切换Nginx使用的PHP版本)
    - [3.2 安装PHP扩展](#32-安装PHP扩展)
- [4.添加快捷命令](#4添加快捷命令)
- [5.日志说明](#5日志说明)
- [6.PHP镜像选择](#6PHP镜像选择)
- [7.存在问题](#7存在问题)

## 1.目录结构

```
/
├── conf                                配置文件目录
│   ├── mysql                           MySQL目录
│   │    └── mysql.cnf                  MySQL用户配置文件
│   ├── nginx                           Nginx目录
│   │    ├── conf.d                     Nginx配置目录
│   │    │    └── certs                 Https站点证书目录
│   │    ├── vhost                      Nginx用户站点配置目录
│   │    │    ├── localhost.conf        Nginx用户站点配置目录
│   │    │    └── localhost_https.conf  localhost的https站点配置目录
│   │    └── nginx.conf                 Nginx默认配置
│   ├── php                             php配置目录
│   │    ├── php.ini                    PHP默认配置文件
│   │    └── php-fpm.conf               PHP-FPM配置文件（部分会覆盖php.ini配置）
│   └── redis                           Redis配置目录
│   │    └── redis.conf                 Redis配置文件
│   ├── supervisord                     Supervisord目录
│   │    ├── supervisord.d              Supervisord配置目录
│   │    │    └── test.ini              Supervisord配置文件
│   │    └── supervisord.conf           Supervisord默认配置文件
├── dockerfile                          构建目录
│   ├── mongodb                         Mongodb构建目录
│   │    └── Dockerfile                 Mongodb构建文件
│   ├── mysql                           MySQL构建目录
│   │    └── Dockerfile                 MySQL构建文件
│   ├── nginx                           Nginx构建目录
│   │    └── Dockerfile                 Nginx构建文件
│   ├── php                             PHP构建目录
│   │    ├── extensions                 PHP扩展目录
│   │    ├── sh                         sh脚本目录
│   │    │    ├── php56.sh              PHP56扩展安装脚本
│   │    │    ├── php72.sh              PHP72扩展安装脚本
│   │    │    ├── superviosord.sh       superviosord安装脚本
│   │    │    └── install.sh            PHP扩展安装脚本
│   │    └── Dockerfile                 Dockerfile构建文件
│   ├── phpredisadmin                   Phpredisadmin构建目录
│   │    └── Dockerfile                 Phpredisadmin构建文件
│   ├── rabbitmq                        Rabbitmq构建目录
│   │    └── Dockerfile                 Rabbitmq构建文件
│   └── redis                           Redis构建目录
│   │    └── Dockerfile                 Redis构建文件
├── log                                 日志目录
├── data                                数据目录
├── docker-compose-sample.yml           Docker-compose配置示例文件
├── env.smaple                          环境配置示例文件
└── www                                 PHP代码目录
```

## 2.使用
1. 本地安装`git`、`docker`和`docker-compose`。
2. `clone`项目
3. 拷贝并命名配置文件，启动：
    ```
    $ cd dnmp
    $ cp env.sample .env
    $ cp docker-compose-sample.yml docker-compose.yml
    $ docker-compose up
    ```
4. 访问在浏览器中访问：
 - [http://localhost](http://localhost)： 默认*http*站点
 - [https://localhost](https://localhost)：自定义证书*https*站点，访问时浏览器会有安全提示，忽略提示访问即可
两个站点使用同一PHP代码：`./www/localhost/index.php`。

要修改端口、日志文件位置、php代码目录位置、php扩展、php镜像版本等，请修改**.env**文件，然后重新构建：
```bash
$ docker-compose build php72    # 重建单个服务
$ docker-compose build          # 重建全部服务

```


## 3.PHP和扩展
### 3.1 切换Nginx使用的PHP版本
如果同时创建 **PHP5.6和PHP7.2** 2个PHP版本的容器，

切换PHP仅需修改相应站点 Nginx 配置的`fastcgi_pass`选项，

例如，示例的 [http://localhost](http://localhost) 用的是PHP7.2，Nginx 配置：
```
    fastcgi_pass   php72:9000;
```
要改用PHP5.6，修改为：
```
    fastcgi_pass   php56:9000;
```
再 **重启 Nginx** 生效。
```bash
$ docker exec -it dnmp_nginx_1 nginx -s reload
```
### 3.2 安装PHP扩展
PHP的很多功能都是通过扩展实现，而安装扩展是一个略费时间的过程，
所以，除PHP内置扩展外，在`env.sample`文件中默认安装少量扩展，
如果要安装更多扩展，请打开你的`.env`文件修改如下的PHP配置，
增加需要的PHP扩展：
```bash
PHP72_EXTENSIONS=pdo_mysql,opcache,redis       # PHP 7.2要安装的扩展列表，英文逗号隔开
PHP56_EXTENSIONS=opcache,redis                 # PHP 5.6要安装的扩展列表，英文逗号隔开
```
然后重新build PHP镜像。
    ```bash
    docker-compose build php72
    docker-compose up -d
    ```
可用的扩展请看同文件的`PHP extensions`注释块说明。

## 4.添加快捷命令
在开发的时候，我们可能经常使用`docker exec -it`切换到容器中，把常用的做成命令别名是个省事的方法。

打开~/.bashrc，加上：
```bash
alias dnginx='docker exec -it dnmp_nginx_1 /bin/sh'
alias dphp72='docker exec -it dnmp_php72_1 /bin/sh'
alias dphp56='docker exec -it dnmp_php56_1 /bin/sh'
alias dmysql='docker exec -it dnmp_mysql_1 /bin/bash'
alias dredis='docker exec -it dnmp_redis_1 /bin/sh'
```
其它的服务一样，自行设置

## 5.使用Log
Log文件生成的位置依赖于conf下各log配置的值。<br/>
有些软件的log不在log目录，是因为有些软件的log是跟data目录存放在一起的，例如：
构建MySQL时，已经映射了整个mysql目录，mysql.error.log和mysql.slow.log在data目录的mysql目录下。<br/>
PHP-FPM的日志会输出到Nginx的日志中，所以无需配置它的日志目录

## 6.PHP镜像选择
PHP镜像支持多个版本，可以查看：https://github.com/docker-library/repo-info/tree/master/repos/php/remote。<br/>
如果你用swoole不需要php-fpm的话，可以使用7.2-cli-alpine，如果需要php-fpm则用7.2-fpm-alpine。

## 7.存在问题
1：目前在dockerfile/php/Dockerfile文件中，无法使用$(nproc)，使用会报错，无法拿到cpu的数目<br/>
2：supervisord脚本安装时，启动无效果，需要进入容器启动才行


