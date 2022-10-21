---
layout:     post
title:      Docker Desktop和雷电模拟器不兼容
subtitle:   
date:       2022-10-21
author:     Distiny
header-img: img/post-bg-docker.png
catalog: false
tags:
    - 配置
---

### 情况

电脑上面同时装了Docker Desktop和雷电模拟器，属于一个能打开一个就打不开，寄！

Docker Desktop是原住民，然后装上了模拟器，一顿操作模拟器能用了，然后Docker Desktop就寄了，再根据网上操作把Docker Desktop重装了一下，模拟器继续寄。。。

### 原因

这两个玩意因为docker要求hyper-v要开着，而雷电模拟器运行必须把这个关了

### 解决方法

用docker的时候

- `bcdedit /set hypervisorlaunchtype auto`
- 重启电脑

用雷电模拟器的时候

- bcdedit /set hypervisorlaunchtype off
- 重启电脑

### 就是麻烦！！！辛亏不是频繁用模拟器！！！

