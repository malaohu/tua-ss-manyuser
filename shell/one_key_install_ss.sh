#! /bin/bash
echo "install the required environment ..."
yum -y install git m2crypto
wget https://bootstrap.pypa.io/ez_setup.py -O - | python
wget https://pypi.python.org/packages/source/p/pip/pip-6.0.7.tar.gz
tar zxvf pip-6.0.7.tar.gz
cd pip-6.0.7
python setup.py install
pip install cymysql

echo "download shadowsocks  ..."

git clone -b master https://github.com/malaohu/tua-ss-manyuser /root/
chmod 775 /root/tua-ss-manyuser/shell/checkProcess.sh
chmod 775 /root/tua-ss-manyuser/shell/ssstart.sh
echo "add check ss status shell ..."
echo "*/30 * * * * bash /root/tua-ss-manyuser/shell/checkProcess.sh \"server.py\" \"/root/tua-ss-manyuser/shell/ssstart.sh\"" >> /var/spool/cron/root
vi /root/tua-ss-manyuser/shadowsocks/Config.py
echo "/root/tua-ss-manyuser/shell/ssstart.sh" >> /etc/rc.local

echo "restart crond  ..."
service crond reload
service crond restart