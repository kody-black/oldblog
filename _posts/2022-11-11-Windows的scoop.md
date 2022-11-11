---
layout:     post
title:      Windows的Scoop
subtitle:   安装scoop及配置java
date:       2022-11-11
author:     Distiny
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - 工具
    - Java
---
## Scoop

### 安装

> 参考自[windows命令行包管理工具 -Scoop](https://blog.csdn.net/weixin_44971640/article/details/126957440?spm=1001.2014.3001.5501)

```
# 打开powershell并开启远程权限
Set-ExecutionPolicy RemoteSigned -scope CurrentUser;

# 自定义Scoop安装目录
$env:SCOOP='D:\scoop'
# 用户环境变量
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
#'user'为当前电脑的用户名
# 系统环境变量
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL,'Machine')

# 使用国内镜像下载并安装Scoop
iwr -useb https://gitee.com/glsnames/scoop-installer/raw/master/bin/install.ps1 | iex
scoop config SCOOP_REPO 'https://gitee.com/glsnames/scoop-installer'
scoop update

# 用scoop安装java
scoop bucket add java
scoop install openjdk14
```

### 切换Java版本

```
scoop reset openjdk[版本号]
```

这样可以直接秒切换java版本

如果有问题，看下环境变量进行调整

### 注意打开jar的默认程序

如果遇到无法打开jar文件的情况，需要在注册表里面

`计算机\HKEY_CLASSES_ROOT\Applications\java.exe\shell\open\command`

设置为`"D:\scoop\apps\openjdk14\current\bin\java.exe" -jar "%1"`

