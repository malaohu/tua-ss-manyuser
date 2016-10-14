#! /bin/bash
echo "install the required environment ..."
MYDIR=`pwd`
yum -y install git m2crypto
wget https://bootstrap.pypa.io/ez_setup.py -O - | python
wget https://pypi.python.org/packages/source/p/pip/pip-6.0.7.tar.gz
tar zxvf pip-6.0.7.tar.gz
cd pip-6.0.7
python setup.py install
pip install cymysql

echo "download shadowsocks  ..."

git clone -b master https://github.com/malaohu/tua-ss-manyuser $MYDIR/
chmod 775 $MYDIR/tua-ss-manyuser/shell/checkProcess.sh
chmod 775 $MYDIR/tua-ss-manyuser/shell/ssstart.sh
echo "add check ss status shell"
echo "*/30 * * * * bash "+ $MYDIR +"/tua-ss-manyuser/shell/checkProcess.sh \"server.py\" \""+ $MYDIR +"/shell/ssstart.sh\"" >> /var/spool/cron/root
vi $MYDIR/tua-ss-manyuser/shadowsocks/Config.py
echo $MYDIR + "/tua-ss-manyuser/shell/ssstart.sh" >> /etc/rc.local

echo "restart crond  ..."
service crond reload
service crond restart