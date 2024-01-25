---
layout:     post
title:      ssh突然连不上GitHub的问题
subtitle:   
date:       2024-01-26
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - 配置
---

一个多月没有GitHub传东西，今天更新博客，发现pull不了了，报错如下：

```bash
git pull origin main
ssh: connect to host github.com port 22: Connection timed out
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

```

经过测试经过测试，`ssh -T git@ssh.github.com`会返回`ssh: connect to host github.com port 22: Unknown error`

但是`ssh -T -p 443 git@ssh.github.com` 可以成功访问

既然通过443端口可以访问，那么就修改一下ssh配置，在~/.ssh/config中添加如下内容：

```
Host github.com
  Hostname ssh.github.com
  Port 443
```

之后就没问题了

原因的话，可能是有时候防火墙会拒绝ssh的22端口连接，但Windows防火墙策略应该没有修改过，不是很会这个，暂且如此吧。

遇到类似问题，参考github中的方案：[SSH 故障排除 - GitHub 文档](https://docs.github.com/zh/authentication/troubleshooting-ssh)
