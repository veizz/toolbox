## 通过跳板机登录主机

* 先配置ssh，设置sshmaster  
* 将goto, goto.exp放置到$PATH目录下,**我经常使用~/bin/**  
* 将goto.conf放置到goto中指定的目录下,**我经常使用~/etc/**    

###　配置ssh的controlmaster

在~/.ssh/目录下，修改config文件
    
    # vi ~/.ssh/config
    # 文件内容如下,详细说明可以参考：http://www.linuxnote.org/ssh-connection-number-one-action-is-to-specify-a-password.html

    Host relay01.baidu.com
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p

### 部署脚本  

    # vi ~/.bashrc
    # 添加一行

    PATH=~/bin:$PATH

    # source ~/.bashrc

### 将经常使用的主机添加到goto.conf文件中

    #　第一列hostname, 第二列username，第三列密码
    #　以＃开头的行被忽略

    # host user pass
    www.baidu.com username password

### 修改goto脚本中配置

修改home_dir, bridge_username, bridge_host, exp_path, conf_path, conf_file的值


### 使用
    
使用如下命令即可通过跳板机登录, baidu为其中一个host的一部分。使用grep来定位到这一行配置，如果grep的结果是多行，使用第一个。所以选好每个主机的关键字，才会准确登录到目的主机

    goto baidu

