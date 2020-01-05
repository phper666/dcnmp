###注意
supervisord可以安装在宿主机也可以安装在容器内，建议把supervisord安装在宿主机来管理，因为容器挂了，supervisord需要重新进入容器开启supervisord。

宿主机安装supervisord(centos7):
### 安装 epel 源，如果此前安装过，此步骤跳过
~~~
yum install -y epel-release
yum install -y supervisor  
# 如果有提示覆盖原来的supervisord.conf文件，输入y，再按enter键
cp dcnmp/php/conf/supervisord/supervisord.conf /etc/supervisord.conf
# 赋值ini配置文件到/etc/supervisord.d
cp dcnmp/php/conf/supervisord/centos7_supervisord_hyperf.ini.bak /etc/supervisord.d/hyperf.ini
# 开启supervisord
supervisord -c /etc/supervisord.conf
supervisorctl reload
supervisorctl update
supervisorctl restart all
# 给supervisord sock文件最高权限，因为偶尔会出现拒绝连接的问题
chmod 777 /var/run/supervisor.sock
~~~


###遇到问题
mac环境下使用supervisorctl会报http://localhost:9001 refused connection，这个是因为mac默认把supervisor的配置放到/usr/local/etc/supervisord.ini,而使用supervisorctl这个命令默认拿的是/usr/etc/supervisord.conf的配置，所以导致了这个问题   
解决：sudo ln -sv /usr/local/etc/supervisord.ini /etc/supervisord.conf   #建立一个软连接
