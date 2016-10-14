#! /bin/bash
echo "install the required environment ..."
MYDIR=`pwd`
SSDIR=$MYDIR"""/a"
yum -y install git m2crypto
wget https://bootstrap.pypa.io/ez_setup.py -O - | python
wget https://pypi.python.org/packages/source/p/pip/pip-6.0.7.tar.gz
tar zxvf pip-6.0.7.tar.gz
cd pip-6.0.7
python setup.py install
pip install cymysql

echo "download shadowsocks  ..."

git clone -b master https://github.com/malaohu/tua-ss-manyuser $SSDIR
chmod 775 $SSDIR/shell/checkProcess.sh
chmod 775 $SSDIR/shell/ssstart.sh
echo "add check ss status shell ..."
echo "*/30 * * * * bash "$SSDIR"/shell/checkProcess.sh \"server.py\" \""$SSDIR"/shell/ssstart.sh "$SSDIR"\"" >> /var/spool/cron/root
vi $SSDIR/shadowsocks/Config.py
echo $SSDIR + "/shell/ssstart.sh" >> /etc/rc.local

echo "restart crond  ..."
service crond reload
service crond restart

$SSDIR/shell/ssstart.sh $SSDIR