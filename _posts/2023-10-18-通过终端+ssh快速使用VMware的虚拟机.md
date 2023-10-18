---
layout:     post
title:      通过终端+ssh快速使用VMware的虚拟机
subtitle:   
date:       2023-10-18
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - 配置

---

### 虚拟机中的ssh设置

```bash
sudo apt-get install ssh
mkdir ~/.ssh
vim ~/.ssh/authorized_keys
# 复制物理机中的公钥内容 
# 一般位于主机 C:\Users\username\.ssh\id_rsa.pub
```

### 物理机中设置

创建bat文件：`C:\Users\24426\ubuntu22.bat`

```bat
# 进入VMware目录
cd "C:\Program Files (x86)\VMware\VMware Workstation"

# 用vmrun打开对应的虚拟机
:waitForSSH
.\vmrun.exe start "D:\Documents\Virtual Machines\Ubuntu23\Ubuntu23.vmx" nogui
ping -n 1 192.168.211.138 | find "TTL=" >nul
if errorlevel 1 (
    timeout /t 5 >nul
    goto waitForSSH
)
# ssh登录
ssh kody@192.168.211.138
```

新建配置文件如下：

命令行设置为：

`%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe .\ubuntu22.bat`

![16976147074431697614706419.png](https://fastly.jsdelivr.net/gh/distiny-cool/pictures@main/images/16976147074431697614706419.png)

---

完成以上工作后，就可以快速打开Vmware中的虚拟机了（注意需要在启动项里面开启vmware-tray.exe）
