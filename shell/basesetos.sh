#! /bin/bash

#修改系统时区为 中国上海
rm -rf /etc/localtime 
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 


#修改SSH端口为2222
cp /etc/ssh/sshd_config  /etc/ssh/sshd_config_bak
sed 's/\#Port 22/Port 2222/' /etc/ssh/sshd_config_bak > /etc/ssh/sshd_config
/etc/init.d/sshd restart &>/dev/null

#防火墙设置
iptables -t filter -A INPUT -p tcp --dport 2222 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --sport 2222 -j ACCEPT
/etc/init.d/iptables save &>/dev/null

#修改最大连接数
echo "* soft nofile 51200" >> /etc/security/limits.conf
echo "* hard nofile 51200" >> /etc/security/limits.conf

sysctl -p
