#用于统计每个端口每天的流量情况。
#完全利用Mysql的定时任务完成。
#使用前，确认Mysql版本 >= 5.1.6


#创建统计表
DROP TABLE IF EXISTS `user_traffic`;
CREATE TABLE `user_traffic` (
  `port` int(11) NOT NULL,
  `date` date NOT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `u` bigint(20) DEFAULT '0',
  `last_u` bigint(20) DEFAULT NULL,
  `d` bigint(20) DEFAULT '0',
  `last_d` bigint(20) DEFAULT NULL,
  `t` int(11) DEFAULT '0',
  PRIMARY KEY (`port`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


#创建存储过程
CREATE PROCEDURE build_day_traffic()
BEGIN
INSERT into user_traffic (`port`, `date`, ip, u, last_u, d, last_d, t)
SELECT
	a.`port`,
	CURRENT_DATE(),
	'' AS ip,
	(a.u - IFNULL(b.last_u, 0)),
	a.u,
	(a.d - IFNULL(b.last_d, 0)),
	a.d,
	a.t
FROM
	user a
LEFT JOIN user_traffic b ON a.`port` = b.`port`
AND b.date = date_add(CURRENT_DATE(), interval -1 day);
END



#开启MYSQL的任务计划
set global event_scheduler =1; 


#创建任务计划，每天23点50执行
CREATE EVENT e_build_day_traffic 
ON SCHEDULE EVERY 1 DAY STARTS '2017-01-06 23:50:00' 
do call build_day_traffic(); 

#查看任务计划
show EVENTS;

#删除任务计划
#DROP EVENT IF EXISTS e_build_day_traffic; 




