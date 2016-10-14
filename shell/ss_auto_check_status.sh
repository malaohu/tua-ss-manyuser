#!/bin/sh

mkdir /root/shell
wget http://7xnve2.com1.z0.glb.clouddn.com/checkProcess.sh -P /root/shell
wget http://7xnve2.com1.z0.glb.clouddn.com/ssstart.sh -P /root/shell
chmod 775 /root/shell/checkProcess.sh
chmod 775 /root/shell/ssstart.sh
echo "*/15 * * * * bash /root/shell/checkProcess.sh \"server.py\" \"/root/shell/ssstart.sh\"" >> /var/spool/cron/root
