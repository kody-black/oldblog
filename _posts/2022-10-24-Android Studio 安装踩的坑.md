---
layout:     post
title:      Android Studio 重装踩的坑
subtitle:   
date:       2022-10-24
author:     Distiny
header-img: img/post-bg-swift.jpg
catalog: true
tags:
    - 安卓
---

### 情况

AS太太太占内存了，于是我采用最粗暴的方法解决这个问题，重装！

### 1. 卸载

参考：https://blog.csdn.net/weixin_45048331/article/details/111868109

### 2. 安装

正常安装完成后一定要设置代理：

路径：`File->Settings->Appearance & Behavior->System Settings->HTTP Proxy`

![](https://img-blog.csdnimg.cn/20200907185127232.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM2NjA0NTM2,size_16,color_FFFFFF,t_70#pic_center)

设置`http://mirrors.neusoft.edu.cn/`的开源镜像，设置完成后，“Android SDK”中会自动加载出获取资源的国内镜像地址，packages也会加载完全

虽然有梯子，但是镜像还是香的~~

### 3. 运行项目

因为我直接把SDK设的是最高版本，运行别人的项目总会有不兼容的问题，这时候还是因为仔细看看出错的原因，往往改一下gradle就好了。也算是做了好几个安卓项目了，对这个SDK、Gradle等知识还是不太懂，有空多了解了解吧（还是说早点把这个大作业肝完卸掉AS吧）

