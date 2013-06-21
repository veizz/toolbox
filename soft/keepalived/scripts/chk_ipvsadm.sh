#!/bin/bash
#
# author: 
# description: /root/keepalived/chk_ipvsadm.sh
# 定时查看ipvsadm是否存在，如果不存在则启动ipvsadm，
# 如果启动失败，则停止keepalived
# 这时由于主备策略，会切换到backup keepalived
#
#status=$(ps aux|grep ipvsadm | grep -v grep | grep -v bash | wc -l)
status=$(service ipvsadm status| grep -v 'not running'| wc -l)
if [ "${status}" = "0" ]; then
        #service ipvsadm start
	ipvsadm
        #status2=$(ps aux|grep ipvsadm | grep -v grep | grep -v bash |wc -l)
	status2=$(service ipvsadm status| grep -v 'not running'| wc -l)
        if [ "${status2}" = "0"  ]; then
                /etc/init.d/keepalived stop
        fi
fi
