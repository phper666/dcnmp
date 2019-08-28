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
supervisorctl reread
supervisorctl update
supervisorctl restart all
# 给supervisord sock文件最高权限，因为偶尔会出现拒绝连接的问题
chmod 777 /var/run/supervisor.sock
~~~
