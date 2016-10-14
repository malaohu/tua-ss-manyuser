#!/bin/bash
	
cd $1/shadowsocks
ulimit -n 51200
nohup /usr/bin/python server.py >> /var/log/shadowsocks_$(date +%Y%m%d).log 2>&1 &
