---
layout:     post
title:      ctf-wiki中题目ret2shellcode的问题
subtitle:   
date:       2023-09-26
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - pwn
---

原题目如下：

[基本 ROP - CTF Wiki (ctf-wiki.org)](https://ctf-wiki.org/pwn/linux/user-mode/stackoverflow/x86/basic-rop/#ret2shellcode)

按照叙述，通过vmmap查看该文件的bss段应该是可执行的。

但是，实际上情况如下

![16956582328991695658232583.png](https://fastly.jsdelivr.net/gh/distiny-cool/pictures@main/images/16956582328991695658232583.png)

![16956588728991695658872696.png](https://fastly.jsdelivr.net/gh/distiny-cool/pictures@main/images/16956588728991695658872696.png)

可以看到，无论是gdb中查看还是readelf查看，bss段都是不可执行的。

最后找到原因如下（linux内核版本5.8之后有激进的内存保护）

[basic-rop存在不适用的情况。ret2shellcode在ubuntu 20.04.1上运行时，.bss段无x权限。 · Issue #830 · ctf-wiki/ctf-wiki (github.com)](https://github.com/ctf-wiki/ctf-wiki/issues/830)
