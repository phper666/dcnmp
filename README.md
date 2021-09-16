# 注意  
1、默认使用php7.3的镜像，如果你要用php7.2,请记得修改nginx的php代理配置  
2、如果你要使用多个php-fpm容器，记得修改php-fpm容器内的监听9000端口，如果多个php-fpm容器端口都是9000，那么只会生效一个，nginx转发到其它的php-fpm容器会直接502，默认php和php7两个容器时，则不需要修改，我已经修改好了，一个监听9000，另一个监听9001。如果你还要增加多个，则请查看php/conf/zz-docker.conf配置，可以直接修改php-fpm的监听端口。  
3、php扩展去掉了大部分压缩包安装，因为扩展一更新，需要去下载最新扩展覆盖，太麻烦，所以采用了pecl和install-php-extensions安装，后续会慢慢去掉pecl安装，因为install-php-extensions非常的强大，支持安装的扩展也非常多。采用pecl安装扩展有一个弊端，那就是如果安装的扩展有其它依赖，你需要先安装依赖才能安装扩展。使用install-php-extensions就不一样，install-php-extensions的作者已经写好了支持扩展需要的依赖，你安装扩展时，会自动帮你安装依赖，github地址：https://github.com/mlocati/docker-php-extension-installer
```
location ~ \.php$ {
        fastcgi_pass   php:9000;  #这里要改为php7,对应你composer.yml里面的
        fastcgi_index  index.php;
        include        fastcgi_params;
        fastcgi_param  PATH_INFO $fastcgi_path_info;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    }
```

集成了多个服务，目前有nginx、php、mysql、mongodb、redis、rabbitmq、phpredisadmin、supervisord(安装在php容器中)。如果你想支持更多的服务，可以参考原有的服务目录结构、env.sample配置、docker-compose-sample.yml配置

# 目录
- [1.目录结构](#1目录结构)
- [2.使用](#2使用)
- [3.PHP扩展](#3PHP和扩展)
- [4.添加快捷命令](#4添加快捷命令)
- [5.配置文件说明](#5配置文件说明)
- [6.PHP镜像选择](#6PHP镜像选择)
- [7.nodejs镜像选择](#7nodejs镜像选择)
- [8.监控文件变化](#8监控文件变化)
- [9.存在问题](#9存在问题)
- [10.swoole框架建议](#10swoole框架建议)

## 1.目录结构

```
/
├── mongodb                             Mongodb
│   └── Dockerfile                      Mongodb构建文件
├── Mysql                               Mysql目录
│   ├── conf                            Mysql配置文件目录
│   │    └── mysql.cnf                  mysql配置文件
│   └── Dockerfile                      Mysql构建文件
├── nginx                               Nginx
│   ├── conf                            Mysql配置文件目录
│   │    ├── conf.d                     Nginx站点ssh秘钥目录
│   │    ├── vhost                      Nginx虚拟站点配置目录
│   │    └── nginx.conf                 Nginx默认配置文件
│   └── Dockerfile                      Nginx构建文件
├── PHP                                 PHP
│   ├── conf                            PHP配置文件目录
│   │    ├── supervisord.d              supervisord配置目录
│   │    ├── php.ini                    PHP配置文件
│   │    └── php-fpm.conf               php-fpm配置文件
│   ├── extensions                      PHP扩展目录(为了快速构建可以先下载好一些扩展)
│   ├── sh                              构建中运行脚本目录
│   └── Dockerfile                      PHP构建文件
├── phpredisadmin                       redis界面管理
│   └── Dockerfile                      phpredisadmin构建文件
├── rebbitmq                            rebbitmq
│   └── Dockerfile                      rebbitmq构建文件
├── redis                               redis
│   └── Dockerfile                      redis构建文件
├── docker-compose-sample.yml           Docker-compose配置示例文件
├── env.smaple                          环境配置示例文件
└── README.MD                           文档说明
```

## 2.使用
1. 本地安装`git`、`docker`和`docker-compose`。
2. `clone`项目
3. 拷贝并命名配置文件，启动：
    ```
    $ cd dcnmp
    $ cp env.sample .env
    $ cp docker-compose-php.yml docker-compose.yml
    $ docker-compose up
    ```
4. 访问在浏览器中访问：
 - [http://localhost](http://localhost)： 默认*http*站点
 - [https://localhost](https://localhost)：自定义证书*https*站点，访问时浏览器会有安全提示，忽略提示访问即可
两个站点使用同一PHP代码：`./www/localhost/index.php`。

要修改端口、日志文件位置、php代码目录位置、php扩展、php镜像版本等，请修改**.env**文件，然后重新构建：
```bash
$ docker-compose build php7    # 重建单个服务
$ docker-compose build          # 重建全部服务

```

## 3.PHP扩展
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
    docker-compose build php7
    docker-compose up -d
    ```
可用的扩展请看同文件的`PHP extensions`注释块说明。

## 4.添加快捷命令
在开发的时候，我们可能经常使用`docker exec -it`切换到容器中，把常用的做成命令别名是个省事的方法。

打开~/.bashrc，加上：
```bash
alias dnginx='docker exec -it dcnmp_nginx /bin/sh'
alias dphp='docker exec -it dcnmp_php /bin/sh'
alias dphp7='docker exec -it dcnmp_php7 /bin/sh'
alias dmysql='docker exec -it dcnmp_mysql /bin/bash'
alias dredis='docker exec -it dcnmp_redis /bin/sh'
```
其它的服务一样，自行设置

## 5.配置文件说明
```bash
主要说明几个全局变量：
// php项目代码存放路径，一般映射在宿主机/app目录下
CODE_PATH=/app/www
// 各个服务软件的数据备份，比如mysql、redis等等，防止容器挂后数据不见的问题
DATA_PATH=/app/data
// 各个服务的配置,放在当前目录下每个服务目录的conf目录中
CONF_PATH=./
// 各个服务的log
LOG_PATH=/app/log
```
php项目代码、各服务的数据备份、各服务的日志都统一放在放在宿主机/app目录下，方便统一管理。
你也可以把配置也放到这个/app目录下，如果放到/app目录下，需要你提前把所有的服务目录下的conf目录中的所有文件都要复制到/app/conf/xxx服务名。

例如：mysql的配置复制到/app目录下，则为/app/conf/mysql/服务目录下的conf的所有目录文件。然后修改配置文件CONF_PATH=/app/conf

## 6.PHP镜像选择
PHP镜像支持多个版本，可以查看：https://github.com/docker-library/repo-info/tree/master/repos/php/remote

如果你用swoole不需要php-fpm的话，可以使用7.2-cli-alpine，如果需要php-fpm则用7.2-fpm-alpine。

## 7.nodejs镜像选择
nodejs官方镜像有三种，但是目前我们要选择-alpine后缀的，容量小、好用。nodejs搭配nginx很简单，在代理那里转发到nodejs容器即可，例如http://nodejs:3000

## 8.监控文件变化
新增对于hyperf等swoole框架的文件变化重启服务     
进入到php容器直接使用swoolefor即可使用服务，详细请看php容器的~/.bashrc  
如何使用请移步到swoolefor查看文档，地址：https://github.com/mix-php/swoolefor

## 9.存在问题
1：目前在/php/Dockerfile文件中，无法使用$(nproc)，使用会报错，无法拿到cpu的数目

2：如果mysql启动不成功，查看容器报错为：[ERROR] Could not open file '/var/log/mysql/mysql.error.log' for error logging: Permission denied
则需要你删除映射的/app/log/mysql目录，然后重新开启容器,如果还不行，则在宿主机直接运行chmod -R 0777 /app/log/mysql

3：swoole扩展偶尔安装不上去，是因为可能文件损坏，请到https://github.com/swoole/swoole-src/releases 下载对应的版本

## 10.swoole框架建议
1、建议直接在宿主机使用supervisord来管理项目
