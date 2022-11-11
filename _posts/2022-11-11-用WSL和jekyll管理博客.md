---
layout:     post
title:      用WSL和jekyll管理博客
subtitle:   
date:       2022-11-11
author:     Distiny
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - 工具
---
### 使用方式

在博客根目录中，执行

```
wsl jekyll s
```

### 安装过程

首先安装Ruby，然后好像自带gem，用gem安装jekyll

```bash
 sudo apt-get install ruby ruby-dev build-essential dh-autoreconf
 ruby -v
 gem update
 sudo gem update
 sudo gem install jekyll bundler
 jekyll -v
 
 # 分页功能有问题的话
 sudo gem install jekyll-paginate
```

