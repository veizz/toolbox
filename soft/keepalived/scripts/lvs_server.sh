#!/bin/bash
#把一下内容保存成:lvs_server.sh
#并放置在/etc/init.d目录下
#如果想启动LVS Server执行:/etc/init.d/lvs_server.sh start
#如果想停止LVS Server执行:/etc/init.d/lvs_server.sh stop
#如果想重启LVS Server执行:/etc/init.d/lvs_server.sh restart
 
VIP=192.168.1.177 #虚拟IP，更具具体情况而变
#有几个输入几个，与下面的配置对应，同时必须与KeepAlived.config配置对应
RIP1=192.168.1.141 #实际的服务器IP
RIP2=192.168.1.142 #实际的服务器IP
#RIP2=192.168.20.102 #实际的服务器IP
. /etc/rc.d/init.d/functions # 如果提示权限不够，那么先在命令行执行: chmod 777 /etc/rc.d/init.d/functions
case "$1" in
 
start)
        echo "启动LVS服务器"
          #设置虚拟IP和同步参数
          /sbin/ifconfig eth0:0 $VIP broadcast $VIP netmask 255.255.255.255 up
          #echo "1" >/proc/sys/net/ipv4/ip_forward
	  /sbin/sysctl -w net.ipv4.ip_forward=1
          #清空 IPVS的内存数据
          /sbin/ipvsadm -C
 
          #设置LVS
          #开启FTP 21 端口服务，并指向RIP1和RIP2的服务器
          #/sbin/ipvsadm -A -t $VIP:21 -s rr
          #/sbin/ipvsadm -a -t $VIP:21 -r $RIP1:21 -g
          #/sbin/ipvsadm -a -t $VIP:21 -r $RIP2:21 -g
          #/sbin/ipvsadm -a -t $VIP:21 -r $RIP3:21 -g
          #开启WEB 80 端口服务，并指向RIP1和RIP2的服务器
          /sbin/ipvsadm -A -t $VIP:80 -s rr
          /sbin/ipvsadm -a -t $VIP:80 -r $RIP1:80 -g
          /sbin/ipvsadm -a -t $VIP:80 -r $RIP2:80 -g
          #/sbin/ipvsadm -a -t $VIP:80 -r $RIP3:80 -g
          #运行LVS
          /sbin/ipvsadm -ln
          ;;
stop)
       echo "关闭LVS服务器"
       #echo "0" >/proc/sys/net/ipv4/ip_forward
       /sbin/sysctl -w net.ipv4.ip_forward=0
       /sbin/ipvsadm -C
       /sbin/ifconfig eth0:0 down
       ;;
 
restart)
       echo "关闭LVS服务器"
       #echo "0" >/proc/sys/net/ipv4/ip_forward
       /sbin/sysctl -w net.ipv4.ip_forward=0
       /sbin/ipvsadm -C
       /sbin/ifconfig eth0:0 down
 
      echo "启动LVS服务器"
      #设置虚拟IP和同步参数
      /sbin/ifconfig eth0:0 $VIP broadcast $VIP netmask 255.255.255.255 up
      #echo "1" >/proc/sys/net/ipv4/ip_forward
      /sbin/sysctl -w net.ipv4.ip_forward=1
      #清空 IPVS的内存数据
      /sbin/ipvsadm -C
 
      #设置LVS
      #开启FTP 21 端口服务，并指向RIP1和RIP2的服务器
      #/sbin/ipvsadm -A -t $VIP:21 -s rr
      #/sbin/ipvsadm -a -t $VIP:21 -r $RIP1:21 -g
      #/sbin/ipvsadm -a -t $VIP:21 -r $RIP2:21 -g
      #/sbin/ipvsadm -a -t $VIP:21 -r $RIP3:21 -g
      #开启WEB 80 端口服务，并指向RIP1和RIP2的服务器
      /sbin/ipvsadm -A -t $VIP:80 -s rr
      /sbin/ipvsadm -a -t $VIP:80 -r $RIP1:80 -g
      /sbin/ipvsadm -a -t $VIP:80 -r $RIP2:80 -g
      #/sbin/ipvsadm -a -t $VIP:80 -r $RIP3:80 -g
      #运行LVS
      /sbin/ipvsadm -ln
      ;;
*)
       echo "Usage: $0 {start|stop}"
       exit 1
esac
