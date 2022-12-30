---
layout:     post
title:      Windows给ipad充电
subtitle:   
date:       2022-12-30
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - 工具
---

一件小事，记录一下

首先是将ipad作为windows的拓展屏：

使用[Xdisplay](https://www.splashtop.com/tw/wiredxdisplay)，效果很好！

但是，除非是直接用双typeC的苹果数据线连接电脑和ipad，否则用USB连接ipad会显示没有充电（实际上有在充电，但是极慢），而我自己电脑上的typeC接口需要给电脑充点，所有有点不方便。

解决方法：

使用华硕开发的[AI Charge](https://event.asus.com/mb/2010/ai_charger/)，直接下载安装（应该是适用于所有的Windows电脑），完成后重启电脑发现已经可以直接插USB接口给ipad充电了！

主要原理：貌似是Ai Charge会根据连接设备改变USB接口的电流~

